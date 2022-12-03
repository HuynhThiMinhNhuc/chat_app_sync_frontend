import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:chat_app_sync/src/data/network/network.dart';

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

      var messageDbs = await _localDatasource.getMessages(room.id, page, pageSize);
      var userIds = List.of(messageDbs.map((message) => message.createdById));
      var users = await _localDatasource.getUsers(userIds);
      var setUser = Map.fromIterable(users, key: (user) => user.id);

      room.listMessage = List.of(messageDbs.map((message) => Message.fromEntity(message, setUser[message.createdById])));
      room.listJoiner = Map.fromIterable(users.map(User.fromEntity), key: (user) => user.id);

      rooms.add(room);
    }
    // TODO: call from network

    return rooms;
  }
}
