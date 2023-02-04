import 'dart:async';

import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:chat_app_sync/src/data/repository/room_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageController extends GetxController {
  final paggingController =
      PagingController<int, Rx<ChatRoom>>(firstPageKey: 1);
  final int numberPerLoad;
  final RoomRepository roomRepository;
  final ChatRepository chatRepository;
  final listChatRoom = <int, ChatRoom>{}.obs;
  int get currentNumberPage => listChatRoom.length ~/ numberPerLoad;

  HomePageController(this.roomRepository, this.chatRepository,
      [this.numberPerLoad = AppConstant.defaultPageSize]);

  @override
  void onClose() {
    paggingController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    paggingController.addPageRequestListener((pageKey) {
      fectchPage(pageKey);
    });
  }

  onTapOverViewChat(Rx<ChatRoom> chatRoom) {
    Get.toNamed(AppRoutes.chatRoom, arguments: chatRoom);
  }

  Future<void> fectchPage(int pageKey) async {
    final rooms =
        await roomRepository.getRooms(currentNumberPage, numberPerLoad);
    var newRooms = <Rx<ChatRoom>>[];
    for (var room in rooms) {
      if (!listChatRoom.containsKey(room.id)) {
        newRooms.add(room.obs);
        listChatRoom.addAll({room.id: room});
      }
    }
    if (newRooms.isNotEmpty) {
      paggingController.appendLastPage(newRooms);
    }
  }

  FutureOr<void> receiveMessageOfRoom(ChatRoom room) {
    if (listChatRoom.containsKey(room.id)) {
      listChatRoom[room.id]!.listMessage.addAll(room.listMessage);
    } else {
      listChatRoom.addAll({room.id: room});
      roomRepository.createRoom(room);
    }
    chatRepository.receiveMessages(room.listMessage);
  }

  updateLastMessage(Message mess, int roomId) {}

  // addNewMessage(int roomId, Message newMess) {
  //   for (int i = 0; i < listChatRoom.length; ++i) {
  //     if (listChatRoom[i]?.id == roomId) {
  //       listChatRoom[i]!.listMessage.add(newMess);
  //       listChatRoom.refresh();
  //     }
  //   }
  // }
}
