import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/local/models/message.model.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:chat_app_sync/src/data/network/network.dart';

class ChatRepository {
    final NetworkDatasource _networkDatasource;
  final LocalDatasource _localDatasource;

  ChatRepository({
    required NetworkDatasource networkDatasource,
    required LocalDatasource localDatasource,
  })  : _networkDatasource = networkDatasource,
        _localDatasource = localDatasource;

  Future<List<Message>> getMessages(int roomId, int page, int pageSize) async {
    var messageDbs = await _localDatasource.getMessages(roomId, page, pageSize);
    var userIds = List.of(messageDbs.map((message) => message.createdById));
    var users = await _localDatasource.getUsers(userIds);
    var setUsers = Map.fromIterable(users.map(User.fromEntity), key: (user) => user.id);
    // TODO: call network

    return List.of(messageDbs.map((message) => Message.fromEntity(message, setUsers[message.createdById])));
  }

  Future<void> sendMessage(Message message, int roomId) async {
    return _localDatasource.upsertMessage([message.asEntity(roomId)]);
  }
}