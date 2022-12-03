import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/enum/message_status.dart';
import 'package:chat_app_sync/src/data/local/models/message.model.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/model/user.dart';

class Message {
  int? id;
  int? localId;
  User sender;
  String content;
  MessageStatus? messageStatus;
  DateTime createdAt;

  Message({
    required this.id,
    required this.localId,
    required this.content,
    required this.createdAt,
    required this.sender,
    this.messageStatus,
  });

  factory Message.withContent(String content, User sender) => Message(
        id: null,
        localId: null,
        content: content,
        createdAt: DateTime.now(),
        sender: sender,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'],
        localId: null,
        createdAt: DateTime.parse(json['createdAt']),
        sender: User.fromJson(json['sender']),
        content: json['content'],
      );

  bool get isSender => sender == AppManager().currentUser;

  factory Message.fromEntity(MessageModel message, UserModel user) => Message(
        id: message.id,
        localId: message.localId,
        content: message.content,
        createdAt: message.createdAt,
        sender: User.fromEntity(user),
      );

  MessageModel asEntity(int roomId) => MessageModel(
        id: id,
        localId: localId ?? 0,
        createdAt: createdAt,
        content: content,
        createdById: sender.id,
        roomId: roomId,
      );
}
