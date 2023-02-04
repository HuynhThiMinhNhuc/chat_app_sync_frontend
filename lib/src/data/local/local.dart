import 'dart:developer';
import 'dart:io';
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
    //await deleteDatabase(path);

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

        // await db.execute(sampleUsers);
        // await db.execute(sampleRooms);
        // await db.execute(sampleMessages);
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
      SELECT r.*, (CASE WHEN m.id ISNULL THEN m."createdAt" ELSE r."updatedAt" END) as lastMessageTime
      FROM "RoomChat" as r
      LEFT JOIN "Message" as m ON m."roomId" = r."id"
      ORDER BY lastMessageTime DESC
      LIMIT ?
      OFFSET ?
      ''',
      [pageSize, (page - 1) * pageSize],
    );
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
    return List.from(messages.map(MessageModel.fromJson));
  }

  Future<void> upsertMessage(List<MessageModel> messages) async {
    for (var message in messages) {
      try {
        if (message.localId == 0) {
          await instance.insert('Message', message.toJson());
        } else {
          await instance.update('Message', message.toJson());
        }
      } catch (e) {
        log("upsertMessage fail at ${message.toString()}, error: ${e.toString()}");
        rethrow;
      }
    }
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
    return List.from(users.map(UserModel.fromJson));
  }

  Future<void> insertUser(List<UserModel> users) async {
    for (var user in users) {
      await instance.insert('User', user.toJson());
    }
  }

  Future<MyAccount?> getAccountUser() async {
    var users = await instance.rawQuery('SELECT * FROM MyAccount LIMIT 1');
    if (users.isEmpty) {
      return null;
    }
    return MyAccount.fromJson(users[0]);
  }

  Future<bool> setAccountUser(MyAccount? newInstance) async {
    try {
      instance.transaction((txn) async {
        await txn.delete('MyAccount');
        if (newInstance != null) {
          await txn.insert('MyAccount', newInstance.toJson());
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
