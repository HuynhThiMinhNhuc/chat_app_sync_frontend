import 'dart:developer';

import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/common/widget/alert_dialog_widget.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:chat_app_sync/src/data/network/network.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  final inputTextEditingController = TextEditingController();
  final searchTextEditingController = TextEditingController();
  final searchKey = ''.obs;
  final scrollController = ScrollController();
  var isLoading = false.obs;
  var nextPageTrigger = 7;
  final networkDatasource = Get.find<NetworkDatasource>();
  final int numberPerLoad;
  int get currentNumberPage => room.value.listMessage.length ~/ numberPerLoad;

  Rx<ChatRoom> room = Get.arguments;
  final ChatRepository chatRepository;

  ChatRoomController(this.chatRepository,
      [this.numberPerLoad = AppConstant.defaultPageSize]);

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(fetchDataWhenScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    isLoading = true.obs;
    //TODO: fetch next fragment data when user scroll
    final messages = await chatRepository.getMessages(
        room.value.id, currentNumberPage, numberPerLoad);
    room.value.addList(messages);
    isLoading = false.obs;
  }

  Future<void> onSentMessage(BuildContext context) async {
    var currentUser = AppManager().currentUser!;
    final newMessage = Message.withContent(room.value.id,
        inputTextEditingController.text, User.fromAccount(currentUser));

    await chatRepository.sendMessage(newMessage);
    room.value.addList([newMessage]);
    var homePageController = Get.find<HomePageController>();
    homePageController.listChatRoom.sort();
    homePageController.paggingController.itemList?.clear();
    homePageController.paggingController.appendLastPage(homePageController.listChatRoom);
    // homePageController.update();
    networkDatasource.sendMessage(newMessage).then((res) {
      if (res.isSuccess) {
        room.value.addList([res.data!]);
      } else {
        log(res.message.toString());
        room.value.removeMessage(newMessage);
        chatRepository
            .deleteMessage(newMessage.localId)
            .catchError((error) => log("Delete message repo fail"));
        AlertDialogWidget.show(content: 'Không thể gửi tin nhắn');
      }
    });
  }

  fetchDataWhenScroll() async {
    if (scrollController.offset <= scrollController.position.minScrollExtent) {
      await fetchData();
    }
  }

  onNavigateSearchPage() {
    Get.toNamed(AppRoutes.searchPage,
        arguments: searchTextEditingController.text);
  }

  onChangeKeySearch(String? value) {
    if (value != null) {
      searchKey.value = value;
    }
  }

  void search() async {
    final searchResult = await chatRepository.search(
        searchTextEditingController.text, room.value.id);
    if (searchResult.isSuccess) {
      Get.toNamed(AppRoutes.searchPage, arguments: searchResult.data);
    } else {
      AlertDialogWidget.show(content: searchResult.message);
    }
  }
}
