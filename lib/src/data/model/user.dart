import 'package:chat_app_sync/src/data/local/models/my_account.model.dart';
import 'package:chat_app_sync/src/data/local/models/user.model.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';

class User {
  final int id;
  final String userName;
  final String? imageUri;

  User({
    required this.id,
    required this.userName,
    required this.imageUri,
  });

  factory User.fromAccount(MyAccount account) => User(
        id: account.id,
        userName: account.name,
        imageUri: account.imageUri,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        userName: json['name'],
        imageUri: json['imageUri'],
      );

  factory User.fromEntity(UserModel user) => User(
        id: user.id,
        userName: user.name,
        imageUri: user.imageUri,
      );

  UserModel asEntity() => UserModel(
        id: id,
        name: userName,
        imageUri: imageUri,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'imageUri': imageUri,
    };
  }
}
