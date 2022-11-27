import 'package:chat_app_sync/src/data/model/chat_room.dart';


class User{
  final int id;
  final String userName;
  final String? imageUri;
  final String? token;
  List<ChatRoom>? listRoom;

  User({
    required this.id,
    required this.userName,
    required this.imageUri,
    required this.token,
    this.listRoom,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? 0,
        userName: json['name'] ?? '',
        imageUri: json['imageUri'],
        token: json['token'] ?? '',
      );
}