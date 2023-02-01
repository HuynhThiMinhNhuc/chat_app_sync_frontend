import 'package:chat_app_sync/src/data/local/models/room.model.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:get/get.dart';

class ChatRoom {
  final int id;
  final Rx<String> name;
  final Rx<String?> avatarUri;
  final DateTime createdAt;
  final DateTime updatedAt;
  RxList<Message> listMessage;
  RxMap<int, User> listJoiner;
  Rx<Message?> get lastMessage => listMessage.isEmpty ? null.obs : listMessage.last.obs;

  ChatRoom({
    required this.id,
    required this.avatarUri,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.listJoiner,
    required this.listMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] is String
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        updatedAt: json['updatedAt'] is String
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
        avatarUri: json['avatarUri'],
        listMessage: List.of((json['messages'] as List<Map<String, dynamic>>)
                .map(Message.fromJson))
            .obs,
        listJoiner: {
          for (var element in (json['joiners'] as List<Map<String, dynamic>>)
              .map(User.fromJson))
            element.id: element
        }.obs,
      );

  factory ChatRoom.fromEntity(RoomChatModel room) => ChatRoom(
        id: room.id,
        avatarUri: room.avatarUri.obs,
        name: room.name.obs,
        createdAt: room.createdAt,
        updatedAt: room.updatedAt,
        listJoiner: <int, User>{}.obs,
        listMessage: <Message>[].obs,
      );

  addOrReplaceMessage(Message newMessage) {
    for (var message in listMessage) {
      if (message.identify == newMessage.identify) {
        continue;
      }
      if (message.localId == newMessage.localId && message.localId != null) {
        message = newMessage;
      }
    }
  }

  RoomChatModel asEntity() => RoomChatModel(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        name: name.value,
      );
}
