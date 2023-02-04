import 'dart:convert';

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
    required this.id,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() {
    var result = {
      'createdAt': createdAt.toIso8601String(),
      'content': content,
      'createdById': createdById,
      'roomId': roomId,
      'id': id,
    };
    if (localId > 0) {
      result.addAll({'localId': localId});
    }

    return result;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        localId: json['localId'],
        createdAt: DateTime.parse(json['createdAt'].toString()) ,
        content: json['content'],
        createdById: json['createdById'],
        roomId: json['roomId'],
        id: json['id'],
      );

      @override
  String toString() {
    return jsonEncode(toJson());
  }
}
