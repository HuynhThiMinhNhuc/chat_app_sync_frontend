import 'package:chat_app_sync/src/data/chat_room.dart';

class User{
  final String id;
  String? name;
  List<ChatRoom>? listRoom;
  

  User({required this.id, this.name, this.listRoom});

  factory User.fromJson(Map<String, dynamic> json) => User(id:json['id'] ?? '',name: json['name'] ?? '' );


}