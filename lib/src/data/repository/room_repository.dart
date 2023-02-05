import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:chat_app_sync/src/data/network/network.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class RoomRepository {
  final NetworkDatasource _networkDatasource;
  final LocalDatasource _localDatasource;

  RoomRepository({
    required NetworkDatasource networkDatasource,
    required LocalDatasource localDatasource,
  })  : _networkDatasource = networkDatasource,
        _localDatasource = localDatasource;

  Future<List<ChatRoom>> getRooms(int page, int pageSize) async {
    var roomDbs = await _localDatasource.getRooms(page, pageSize);
    var users = <User>[];
    var rooms = <ChatRoom>[];
    for (var roomDb in roomDbs) {
      var room = ChatRoom.fromEntity(roomDb);

      var messageDbs =
          await _localDatasource.getMessages(room.id, page, pageSize);
      var userIds = List.of(messageDbs.map((message) => message.createdById));
      var users = await _localDatasource.getUsers(userIds);
      var setUser = {for (var user in users) user.id: user};

      room.addList(List.of(messageDbs.map(
        (message) => Message.fromEntity(
            message,
            setUser[message.createdById] ??
                const UserModel(id: 0, name: 'Unknow', imageUri: null)),
      )));
      room.listJoiner = Map<int, User>.fromIterable(users.map(User.fromEntity),
          key: (user) => user.id).obs;

      rooms.add(room);
    }

    return rooms;
  }

  Future<void> createRoom(ChatRoom room) {
    return _localDatasource.insertRoom([room.asEntity()]);
  }
}
