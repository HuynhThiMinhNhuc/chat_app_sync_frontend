class MessageModel {
  final int localId;
  final int? id;
  final DateTime createdAt;
  final String content;
  final int createdById;
  final int roomId;

  const MessageModel({
    required this.localId,
    required this.createdAt,
    required this.content,
    required this.createdById,
    required this.roomId,
    this.id,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'createdAt': createdAt,
      'content': content,
      'createdById': createdById,
      'roomId': roomId,
      'id': id,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        localId: json['localId'],
        createdAt: json['createdAt'],
        content: json['content'],
        createdById: json['createdById'],
        roomId: json['roomId'],
        id: json['id'],
      );
}
