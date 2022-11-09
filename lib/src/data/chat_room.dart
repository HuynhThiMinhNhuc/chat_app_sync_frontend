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

  Message? get lastMessage =>
      listMessage != null ? listMessage![listMessage!.length - 1] : null;
}
