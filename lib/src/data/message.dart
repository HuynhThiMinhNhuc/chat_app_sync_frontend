import 'package:chat_app_sync/src/data/enum/message_status.dart';
import 'package:chat_app_sync/src/data/user.dart';

class Message{
  User? sender;
  User? receiver;
  String? conttent;
  MessageStatus? messageStatus;
  bool? isSender;


  Message({this.conttent, this.receiver, this.sender, this.messageStatus, this.isSender});

}