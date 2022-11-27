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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'name': name,
      'avatarUri': avatarUri,
    };
  }

  factory RoomChatModel.fromJson(Map<String, dynamic> json) => RoomChatModel(
        id: json['id'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        name: json['name'],
        avatarUri: json['avatarUri'],
      );
}