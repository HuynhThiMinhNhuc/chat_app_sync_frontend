import 'dart:math';

import 'package:chat_app_sync/src/data/local/models/room.model.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:get/get.dart';

class ChatRoom extends GetxController implements Comparable<ChatRoom> {
  final int id;
  final String name;
  final String? avatarUri;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<Message> listMessage;
  Map<int, User> listJoiner;
  Message? get lastMessage => listMessage.isEmpty ? null : listMessage[0];
  DateTime get maxTime => lastMessage == null
      ? updatedAt
      : lastMessage!.createdAt.isAfter(updatedAt)
          ? updatedAt
          : lastMessage!.createdAt;

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
        name: (json['name'] as String),
        createdAt: DateTime.parse(json['createdAt'].toString()),
        updatedAt: DateTime.parse(json['updatedAt'].toString()),
        avatarUri: (json['avatarUri'] as String?),
        listMessage: List.of((json['messages'] as List<dynamic>).map(
                (j) => Message.fromJson(j as Map<String, dynamic>, json['id'])))
            .obs,
        listJoiner: {
          for (var element in (json['joiners'] as List<dynamic>)
              .map((j) => User.fromJson(j as Map<String, dynamic>)))
            element.id: element
        }.obs,
      );

  factory ChatRoom.fromEntity(RoomChatModel room) => ChatRoom(
        id: room.id,
        avatarUri: room.avatarUri,
        name: room.name,
        createdAt: room.createdAt,
        updatedAt: room.updatedAt,
        listJoiner: <int, User>{}.obs,
        listMessage: <Message>[].obs,
      );

  void addList(List<Message> messages) {
    for (var message in messages) {
      _addOrReplaceMessage(message);
    }
    listMessage.sort();
  }

  void removeMessage(Message message) {
    listMessage.removeWhere((m) => m.localId == message.localId);
  }

  void reversedList<T>(List<T> originalList) {
    for (int i = 0; i < originalList.length ~/ 2; i++) {
      T temp = originalList[i];
      originalList[i] = originalList[originalList.length - i - 1];
      originalList[originalList.length - i - 1] = temp;
    }
  }

  _addOrReplaceMessage(Message newMessage) {
    if (newMessage.id == null && newMessage.localId == 0) {
      listMessage.insert(0, newMessage);
      return;
    }
    for (int i = 0; i < listMessage.length; i++) {
      var message = listMessage[i];
      if (message.identify == newMessage.identify) {
        return;
      }
      if (message.localId != 0 && message.localId == newMessage.localId) {
        listMessage[i] = newMessage;
        return;
      }
      if (message.id != null && message.id == newMessage.id) {
        return;
      }
    }
    listMessage.insert(0, newMessage);
  }

  ChatRoom clone(ChatRoom newData) {
    addList(newData.listMessage);
    return ChatRoom(
      id: newData.id,
      avatarUri: newData.avatarUri,
      name: newData.name,
      createdAt: newData.createdAt,
      updatedAt: newData.updatedAt,
      listJoiner: listJoiner..addAll(newData.listJoiner),
      listMessage: listMessage,
    );
  }

  RoomChatModel asEntity() => RoomChatModel(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        name: name,
      );

  @override
  int compareTo(ChatRoom other) {
    return maxTime.compareTo(other.maxTime);
  }
}
