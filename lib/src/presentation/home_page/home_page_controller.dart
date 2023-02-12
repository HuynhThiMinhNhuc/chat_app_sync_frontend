import 'dart:async';
import 'dart:developer';

import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/common/socket/socket.dart';
import 'package:chat_app_sync/src/common/widget/alert_dialog_widget.dart';
import 'package:chat_app_sync/src/data/local/models/room.model.dart';
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
  final paggingController = PagingController<int, ChatRoom>(firstPageKey: -1);
  final int numberPerLoad;
  final RoomRepository roomRepository;
  final ChatRepository chatRepository;
  final UserRepository userRepository;
  final networkDatasource = Get.find<NetworkDatasource>();
  final socket = Get.find<SocketService>();
  final listChatRoom = <ChatRoom>[];
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
    socket.addEventListener(AppConstant.socketEventReceiveMessage, (e) {
      final message = Message.fromJson(e as Map<String, dynamic>);
      if (message.isSender) return;
      for (var room in listChatRoom) {
        if (room.id == message.roomId) {
          room.addList([message]);
          return;
        }
      }
      networkDatasource.getRooms(0, 1, message.roomId).then((roomRes) {
        if (!roomRes.isSuccess) {
          AlertDialogWidget.show(content: "Phòng không tồn tại");
          return;
        }
        addListRoom(roomRes.data!);
      });
    });
  }

  onTapOverViewChat(Rx<ChatRoom> chatRoom) {
    Get.toNamed(AppRoutes.chatRoom, arguments: chatRoom);
  }

  Future<void> onRefresh() {
    return AppManager().getLastSyncTime().then((lastSync) async {
      final newLastSync = DateTime.now();
      await syncData(lastSync);
      AppManager().setLastSyncTime(newLastSync);
    });
  }

  Future<void> syncData(DateTime? lastSync) async {
    final res = await networkDatasource.syncData(lastSync);
    if (res.isSuccess) {
      for (var roomRes in res.data!['items']) {
        final room = ChatRoom.fromJson(roomRes as Map<String, dynamic>);
        addRoomToUI(room);
      }
    } else {
      log(res.message ?? res.toString());
      AlertDialogWidget.show(content: "Lấy thông tin dữ liệu lỗi");
    }
  }

  Future<void> fectchPage(int pageKey) async {
    final rooms =
        await roomRepository.getRooms(currentNumberPage, numberPerLoad);
    // Call get remot rooms
    if (pageKey != -1) {
      getRemoteRooms(currentNumberPage, numberPerLoad);
    } else {
      AppManager().getLastSyncTime().then((lastSync) {
        if (lastSync == null) {
          return getRemoteRooms(currentNumberPage, numberPerLoad);
        }
        return syncData(lastSync);
      });
    }
    addListRoom(rooms);
    paggingController.itemList?.clear();
    paggingController.appendLastPage(listChatRoom);
  }

  FutureOr<void> addRoomToUI(ChatRoom room) {
    addListRoom([room]);

    var isContainRoom = false;
    for (var r in listChatRoom) {
      if (r.id == room.id) {
        isContainRoom = true;
        break;
      }
    }
    if (!isContainRoom) {
      roomRepository.createRoom(room);
    }

    userRepository.upsertUsers(room.listJoiner.values.toList());
    chatRepository.receiveMessages(room.listMessage);

    paggingController.itemList?.clear();
    paggingController.appendLastPage(listChatRoom);
  }

  Future<void> logout() async {
    AppManager().cleanData();
    Get.offAllNamed(AppRoutes.login);
    return;
  }

  updateLastMessage(Message mess, int roomId) {}
  Future<void> getRemoteRooms(int page, int pageSize) async {
    var res = await networkDatasource.getRooms(page, pageSize);
    if (res.isSuccess) {
      var rooms = res.data!;
      // var newMessages = items.map(Message.fromJson);
      for (var room in rooms) {
        addRoomToUI(room);
      }
    } else {
      log(res.message ?? res.toString());
      AlertDialogWidget.show(
          content: "Lấy thông tin danh sách phòng chat bị lỗi");
    }
  }

  void addListRoom(List<ChatRoom> rooms) {
    for (var newRoom in rooms) {
      var index = 0;
      for (int i = 0; i < listChatRoom.length; i++) {
        var room = listChatRoom[i];
        if (room.id == newRoom.id) {
          listChatRoom[i] = listChatRoom[i].clone(newRoom);
          return;
        }
        var compare = newRoom.compareTo(room);
        if (compare > 1) {
          index = i + 1;
          continue;
        }
      }
      listChatRoom.insert(index, newRoom);
    }
    listChatRoom.sort();
  }
}
