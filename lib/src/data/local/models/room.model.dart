class RoomChatModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String? avatarUri;

  const RoomChatModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.avatarUri,
  });

  Map<String, dynamic> toJson() {
   return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'name': name,
      'avatarUri': avatarUri,
    };
  }

  factory RoomChatModel.fromJson(Map<String, dynamic> json) => RoomChatModel(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt'].toString()),
        updatedAt: DateTime.parse(json['updatedAt'].toString()),
        name: json['name'],
        avatarUri: json['avatarUri'],
      );
}
