import 'package:chat_app_sync/src/data/local/models/room.model.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';

class ChatRoom {
  final int id;
  final String name;
  final String? avatarUri;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<Message> listMessage;
  Map<int, User> listJoiner;
  Message? get lastMessage => listMessage.last;

  ChatRoom({
    required this.id,
    required this.avatarUri,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.listJoiner = const <int, User>{},
    this.listMessage = const <Message>[],
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] is String
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        updatedAt: json['updatedAt'] is String
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
        avatarUri: json['avatarUri'],
        listMessage: List.of(
            (json['messages'] as List<Map<String, dynamic>>)
                .map(Message.fromJson)),
      );

  factory ChatRoom.fromEntity(RoomChatModel room) => ChatRoom(
        id: room.id,
        avatarUri: room.avatarUri,
        name: room.name,
        createdAt: room.createdAt,
        updatedAt: room.updatedAt,
      );

  addOrReplaceMessage(Message newMessage) {
    for (var message in listMessage) {
      if (message.identify == newMessage.identify) {
        continue;
      }
      if (message.localId == newMessage.localId && message.localId != null) {
        message = newMessage;
      }
    }
  }

  RoomChatModel asEntity() => RoomChatModel(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        name: name,
      );
}
