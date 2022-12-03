import 'package:chat_app_sync/src/data/local/models/my_account.model.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';

class User {
  final int id;
  final String userName;
  final String? imageUri;
  List<ChatRoom>? listRoom;

  User({
    required this.id,
    required this.userName,
    required this.imageUri,
    this.listRoom,
  });

  factory User.fromAccount(MyAccount account) => User(
        id: account.id,
        userName: account.name,
        imageUri: account.imageUri,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? 0,
        userName: json['name'] ?? '',
        imageUri: json['imageUri'],
      );

  factory User.fromEntity(UserModel user) => User(
        id: user.id,
        userName: user.name,
        imageUri: user.imageUri,
      );
}
