import '../../model/user.dart';

class UserEntity {
  final int id;
  final String userName;
  final String? imageUri;
  final String password;

  UserEntity({
    required this.id,
    required this.userName,
    required this.imageUri,
    required this.password,
  });

  asUser() => User(
    id: id,
    userName: userName,
    imageUri: imageUri,
    token: '',
  );
}
