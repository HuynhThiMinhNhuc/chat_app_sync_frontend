import 'package:chat_app_sync/src/data/local/models/room.model.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';

class ChatRoom {
  final int id;
  final String name;
  final String? avatarUri;
  final DateTime createdAt;
  List<Message> listMessage;
  Map<int, User> listJoiner;
  Message? get lastMessage => listMessage?.last;

  ChatRoom({
    required this.id,
    required this.avatarUri,
    required this.name,
    required this.createdAt,
    this.listJoiner = const <int, User>{},
    this.listMessage = const <Message>[],
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
    id: json['id'],
    name: json['name'],
    createdAt: DateTime.parse(json['createdAt']),
    avatarUri: json['avatarUri'] ?? '',
    listMessage: List.of((json['list_message'] as List<Map<String,dynamic>>).map(Message.fromJson)),
  );

  factory ChatRoom.fromEntity(RoomChatModel room) => ChatRoom(
        id: room.id,
        avatarUri: room.avatarUri,
        name: room.name,
        createdAt: room.createdAt,
      );
}
