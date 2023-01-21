import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/enum/message_status.dart';
import 'package:chat_app_sync/src/data/local/models/message.model.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/model/user.dart';

class Message implements Comparable<Message> {
  int? id;
  int? localId;
  int roomId;
  User sender;
  String content;
  MessageStatus? messageStatus;
  DateTime createdAt;

  String get identify => '${id ?? '_id_'}_${{localId ?? '_localId_'}}';

  Message({
    required this.id,
    required this.localId,
    required this.content,
    required this.createdAt,
    required this.sender,
    required this.roomId,
    this.messageStatus,
  });

  factory Message.withContent(int roomId, String content, User sender) =>
      Message(
        id: null,
        localId: null,
        content: content,
        createdAt: DateTime.now(),
        roomId: roomId,
        sender: sender,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'],
        localId: json['localId'],
        roomId: json['roomId'],
        createdAt: DateTime.parse(json['createdAt']),
        sender: User.fromJson(json['sender']),
        content: json['content'],
      );

  bool get isSender => AppManager().currentUser?.id == sender.id;

  factory Message.fromEntity(MessageModel message, UserModel user) => Message(
        id: message.id,
        localId: message.localId,
        roomId: message.roomId,
        content: message.content,
        createdAt: message.createdAt,
        sender: User.fromEntity(user),
      );

  MessageModel asEntity() => MessageModel(
        id: id,
        localId: localId ?? 0,
        createdAt: createdAt,
        content: content,
        createdById: sender.id,
        roomId: roomId,
      );

  @override
  int compareTo(Message other) {
    if (id != null && other.id != null) {
      return id!.compareTo(other.id!);
    }
    if (id == null && other.id == null) {
      return localId == null && other.localId == null ? 0 : localId!.compareTo(other.localId!);
    }
    return createdAt.compareTo(other.createdAt);
  }
}
