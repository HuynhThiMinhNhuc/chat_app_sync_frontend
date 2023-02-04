import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  final inputTextEditingController = TextEditingController();
  final searchTextEditingController = TextEditingController();
  final searchKey = ''.obs;
  final scrollController = ScrollController();
  var isLastPage = false.obs;
  var pageNumber = 0.obs;
  var isError = false.obs;
  var isLoading = false.obs;
  var nextPageTrigger = 7;

  Rx<ChatRoom> room = Get.arguments;
  final ChatRepository chatRepository;

  ChatRoomController(this.chatRepository);

  @override
  void onInit() async {
    scrollController.addListener(() async => await fetchDataWhenScroll());
    super.onInit();
  }
//  @override
//   void onReady()async {
//      scrollController.addListener(() async => await fetchDataWhenScroll());
//     super.onReady();
//   }

  //TODO: get data from server
  // final listMessage = [
  //   Message(
  //       conttent: 'hi dddkjhdkjkjdhksssssssssssssssssssssssssj',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'hello',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'How are you?',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'fine', messageStatus: MessageStatus.viewed,  sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'bye', messageStatus: MessageStatus.viewed,  sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'hi dddkjhdkjkjdhksssssssssssssssssssssssssj',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'hello',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'How are you?',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'fine', messageStatus: MessageStatus.viewed,  sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'bye', messageStatus: MessageStatus.viewed,  sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'hi dddkjhdkjkjdhksssssssssssssssssssssssssj',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'hello',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'How are you?',
  //       messageStatus: MessageStatus.viewed,
  //        sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'fine', messageStatus: MessageStatus.viewed,  sender: AppManager().currentUser),
  //   Message(
  //       conttent: 'bye', messageStatus: MessageStatus.viewed,  sender: AppManager().currentUser)
  // ].obs;

  getListMessLength() {
    return room.value.listMessage.length + (isLastPage.value ? 0 : 1);
  }

  fetchData() async {
    isLoading = true.obs;
    //TODO: fetch next fragment data when user scroll
    try {
      await Future.delayed(const Duration(seconds: 5));
      // final newMess = listMessageMock;
      final newMess = <Message>[];
      isLastPage = (newMess.length < AppConstant.defaultPageSize).obs;
      pageNumber += 1;
      room.value.listMessage.insertAll(0, newMess);
    } catch (e) {
      isError = true.obs;
    } finally {
      isLoading = false.obs;
    }
  }

  Future<void> onSentMessage(BuildContext context) async {
    var currentUser = AppManager().currentUser!;
    final newMessage = Message.withContent(room.value.id,
        inputTextEditingController.text, User.fromAccount(currentUser));

    await chatRepository.sendMessage(newMessage);
    room.value.addOrReplaceMessage(newMessage);
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
}
