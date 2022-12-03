class MyAccount {
  final int id;
  final String name;
  final String? imageUri;
  final String userName;
  final String password;
  final String token;

  const MyAccount({
    required this.id,
    required this.name,
    required this.imageUri,
    required this.userName,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUri': imageUri,
      'userName': userName,
      'password': password,
      'token': token,
    };
  }

  factory MyAccount.fromJson(Map<String, dynamic> json) => MyAccount(
        id: json['id'],
        name: json['name'],
        imageUri: json['imageUri'],
        userName: json['userName'],
        password: json['password'],
        token: json['token'],
      );
}
