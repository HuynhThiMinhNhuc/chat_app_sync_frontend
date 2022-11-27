import 'package:chat_app_sync/src/data/message.dart';
import 'package:chat_app_sync/src/data/user.dart';

class ChatRoom {
  final String id;
  String? name;
  List<Message>? listMessage;
  String? avatar;
  List<User>? listJoiner;

  ChatRoom(
      {required this.id,
      this.avatar,
      this.listJoiner,
      this.listMessage,
      this.name});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      listMessage: json['list_message'] == null
          ? null
          : Message.getListMessageFromJson(json['list_message'] as List));

  Message? get lastMessage =>
      listMessage != null ? listMessage![listMessage!.length - 1] : null;

  static List<ChatRoom>? getListChatRoom(List? listJson) {
    if (listJson == null) return null;

    return (listJson.map((json) => ChatRoom.fromJson(json))).toList();
  }
}
