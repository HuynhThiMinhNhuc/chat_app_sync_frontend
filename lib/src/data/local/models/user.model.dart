class UserModel {
  final int id;
  final String name;
  final String? imageUri;

  const UserModel({
    required this.id,
    required this.name,
    required this.imageUri,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUri': imageUri,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        imageUri: json['imageUri'],
      );
}