import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/enum/message_status.dart';
import 'package:chat_app_sync/src/data/local/models/message.model.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/model/user.dart';

class Message implements Comparable<Message> {
  int? id;
  int localId;
  int roomId;
  User sender;
  String content;
  MessageStatus? messageStatus;
  DateTime createdAt;

  String get identify => '${id ?? '_id_'}_${{localId}}';

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
        localId: 0,
        content: content,
        createdAt: DateTime.now(),
        roomId: roomId,
        sender: sender,
      );

  factory Message.fromJson(Map<String, dynamic> json, [int? roomId]) => Message(
        id: json['id'],
        localId: json['localId'] ?? 0,
        roomId: json['roomId'] ?? roomId!,
        createdAt: DateTime.parse(json['createdAt'].toString()),
        sender: User.fromJson(json['createdBy']),
        content: json['content'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'localId': localId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': sender.toJson(),
      'roomId': roomId,
    };
  }

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
        localId: localId,
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
    return createdAt.compareTo(other.createdAt);
  }
}
