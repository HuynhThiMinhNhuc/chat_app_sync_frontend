import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/enum/message_status.dart';
import 'package:chat_app_sync/src/data/model/user.dart';


class Message{
  User? sender;
  User? receiver;
  String? conttent;
  MessageStatus? messageStatus;


  Message({this.conttent, this.receiver, this.sender, this.messageStatus});

factory Message.fromJson(Map<String, dynamic> json) => Message(
  sender: json['sender'] == null ? null : User.fromJson(json['sender']),
  receiver: json['receiver'] == null ? null : User.fromJson(json['receiver']),
  conttent: json['content'] ?? '',
);

bool get isSender => sender == AppManager().currentUser;
  static List<Message>? getListMessageFromJson(List? listJson) {
    if (listJson == null) return null;
    return (listJson.map((json) => Message.fromJson(json))).toList();
  }
}