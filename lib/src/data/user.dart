class User{
  final String id;
  String? name;

  User({required this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(id:json['id'] ?? '',name: json['name'] ?? '' );


}