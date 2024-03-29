import 'dart:developer';
import 'dart:io';
import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/data/local/const.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/local/samples/sample.dart';
import 'package:path/path.dart';
import 'package:chat_app_sync/src/data/local/models/message.model.dart';
import 'package:chat_app_sync/src/data/local/models/my_account.model.dart';
import 'package:chat_app_sync/src/data/local/models/room.model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  Database? _instance;
  Database get instance => _checkInstance(_instance);

  static T _checkInstance<T>(T? instance) {
    assert(() {
      if (instance == null) {
        throw FlutterError("Local database is null");
      }
      return true;
    }());
    return instance!;
  }

  Future<dynamic> ensureInitialized() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "chat_app.db");

    // delete existing if any
    if (AppConstant.isResetDb) {
      await deleteDatabase(path);
    }

    // Check if the database exists
    var exists = await databaseExists(path);
    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // // Copy from asset
      // ByteData data =
      //     await rootBundle.load(join("assets", "migrations", "chat_app.db"));
      // List<int> bytes =
      //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // // Write and flush the bytes written
      // await File(path).writeAsBytes(bytes, flush: true);
    }

    _instance ??= await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(createUser);
        await db.execute(createAccount);
        await db.execute(createRoom);
        await db.execute(createMessage);

        // if (AppConstant.isResetDb) {
        //   await db.execute(sampleUsers);
        //   await db.execute(sampleRooms);
        //   await db.execute(sampleMessages);
        // }
      },
      // onDowngrade: (db, oldVersion, newVersion) => db.execute(dropAllTable),
      version: 1,
    );
    return instance;
  }

  Future<void> close() {
    return instance.close();
  }

  // Future<bool> clearData() async {
  //   try {
  //     await instance.execute(clearAllData);
  //     log('Clear all data success');
  //     return true;
  //   } catch (e) {
  //     log('Clear all data false, error: ${e.toString()}');
  //     return false;
  //   }
  // }

  // Future<bool> deleteAllTable() async {
  //   try {
  //     await instance.execute(dropAllTable);
  //     log('Delete all table success');
  //     return true;
  //   } catch (e) {
  //     log('Delete all table false, error: ${e.toString()}');
  //     return false;
  //   }
  // }

  Future<List<RoomChatModel>> getRooms(int page, int pageSize) async {
    var rooms = await instance.rawQuery(
      '''
      WITH rs as (SELECT r.*, 
      (
        SELECT (CASE WHEN m.id IS NOT NULL THEN m."createdAt" ELSE r."updatedAt" END)
        FROM "Message" as m 
        WHERE TRUE
        AND m."roomId" = r."id"
        ORDER BY m."localId" DESC
        LIMIT 1
      ) as lastMessageTime
      FROM "RoomChat" as r
      )
      SELECT * 
      FROM rs 
      ORDER BY lastMessageTime DESC 
      LIMIT ?
      OFFSET ?
      ''',
      [pageSize, (page - 1) * pageSize],
    );
    log('getRooms success');
    return List.of(rooms.map(RoomChatModel.fromJson));
  }

  Future<void> insertRoom(List<RoomChatModel> rooms) async {
    for (var room in rooms) {
      await instance.insert('RoomChat', room.toJson());
    }
  }

  Future<List<MessageModel>> getMessages(
      int roomId, int page, int pageSize) async {
    var messages = await instance.rawQuery(
      '''
      SELECT *
      FROM "Message"
      WHERE "roomId" = ?
      ORDER BY "createdAt" DESC
      LIMIT ?
      OFFSET ?
      ''',
      [roomId, pageSize, (page - 1) * pageSize],
    );
    log('getMessages success');
    return List.from(messages.map(MessageModel.fromJson));
  }

  Future<void> deleteMessage(int localId) {
    return instance.delete('Message', where: 'localId = ?', whereArgs: [localId]);
  }

  Future<List<int>> upsertMessage(List<MessageModel> messages) async {
    var rs = <int>[];
    for (var message in messages) {
      try {
        if (message.localId == 0) {
          var localId = await instance.insert('Message', message.toJson());
          rs.add(localId);
        } else {
          await instance.update('Message', message.toJson());
          rs.add(message.localId);
        }
        log('upsertMessage success');
      } catch (e) {
        log("upsertMessage fail at ${message.toString()}, error: ${e.toString()}");
        rethrow;
      }
    }
    return rs;
  }

  Future<List<UserModel>> getUsers(List<int> userIds) async {
    var users = await instance.rawQuery(
      '''
      SELECT *
      FROM "User"
      WHERE "id" in (${List.filled(userIds.length, '?').join(',')})
      ''',
      userIds,
    );
    log('getUsers success');
    return List.from(users.map(UserModel.fromJson));
  }

  Future<void> upsertUser(List<UserModel> users) async {
    for (var user in users) {
      await instance.insert('User', user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    log('upsertUser success');
  }

  Future<MyAccount?> getAccountUser() async {
    var users = await instance.rawQuery('SELECT * FROM MyAccount LIMIT 1');
    if (users.isEmpty) {
      return null;
    }
    log('getAccountUser success');
    return MyAccount.fromJson(users[0]);
  }

  Future<void> setAccountUser(MyAccount? newInstance) async {
    try {
      instance.transaction((txn) async {
        await txn.delete('MyAccount');
        if (newInstance != null) {
          await txn.insert('MyAccount', newInstance.toJson());
        }
      });
      log('setAccountUser success');
    } catch (e) {
      log('setAccountUser fail, err: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> cleanData() async {
    try {
      instance.transaction((txn) async {
        await txn.delete('Message');
        await txn.delete('RoomChat');
        await txn.delete('User');
      });
      log('cleanData success');
    } catch (e) {
      log('cleanData fail, err: ${e.toString()}');
      rethrow;
    }
  }
}
