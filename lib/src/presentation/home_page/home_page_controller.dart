import 'dart:async';
import 'dart:developer';

import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/common/widget/alert_dialog_widget.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/network/network.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:chat_app_sync/src/data/repository/room_repository.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageController extends GetxController {
  final paggingController =
      PagingController<int, Rx<ChatRoom>>(firstPageKey: 1);
  final int numberPerLoad;
  final RoomRepository roomRepository;
  final ChatRepository chatRepository;
  final UserRepository userRepository;
  final listChatRoom = <int, ChatRoom>{}.obs;
  int get currentNumberPage => listChatRoom.length ~/ numberPerLoad;

  HomePageController(
      this.roomRepository, this.chatRepository, this.userRepository,
      [this.numberPerLoad = AppConstant.defaultPageSize]);

  @override
  void dispose() {
    paggingController.dispose();
    super.dispose();
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

  Future<void> syncData() async {}

  Future<void> fectchPage(int pageKey) async {
    final rooms =
        await roomRepository.getRooms(currentNumberPage, numberPerLoad);
    // Call get remot rooms
    getRemoteRooms(currentNumberPage, numberPerLoad);
    for (var room in rooms) {
      if (!listChatRoom.containsKey(room.id)) {
        listChatRoom.addAll({room.id: room});
      }
    }
    paggingController.itemList?.clear();
    var listRoomUI = listChatRoom.values.map((e) => e.obs).toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    paggingController.appendLastPage(listRoomUI);
  }

  FutureOr<void> addRoomToUI(ChatRoom room) {
    if (listChatRoom.containsKey(room.id)) {
      listChatRoom[room.id]!.addList(room.listMessage);
    } else {
      listChatRoom.addAll({room.id: room});
      roomRepository.createRoom(room);
      paggingController.itemList?.clear();
      var listRoomUI = listChatRoom.values.map((e) => e.obs).toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      paggingController.appendLastPage(listRoomUI);
    }
    userRepository.upsertUsers(room.listJoiner.values.toList());
    chatRepository.receiveMessages(room.listMessage);
  }

  Future<void> getRemoteRooms(int page, int pageSize) async {
    var res = await Get.find<NetworkDatasource>().getRooms(page, pageSize);
    if (res.isSuccess) {
      var rooms = res.data!;
      // var newMessages = items.map(Message.fromJson);
      for (var room in rooms) {
        addRoomToUI(room);
      }
      update();
    } else {
      log(res.message ?? res.toString());
      AlertDialogWidget.show(
          content: "Lấy thông tin danh sách phòng chat bị lỗi");
    }
  }

  // addNewMessage(int roomId, Message newMess) {
  //   for (int i = 0; i < listChatRoom.length; ++i) {
  //     if (listChatRoom[i]?.id == roomId) {
  //       listChatRoom[i]!.listMessage.add(newMess);
  //       listChatRoom.refresh();
  //     }
  //   }
  // }
}
