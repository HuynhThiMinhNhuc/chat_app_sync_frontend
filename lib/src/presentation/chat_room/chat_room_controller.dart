import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  final inputTextEditingController = TextEditingController();
  final scrollController = ScrollController();
  final isLastPage = false.obs;
  final pageNumber = 0.obs;
  final isError = false.obs;
  final isLoading = false.obs;
  final nextPageTrigger = 7;

  ChatRoom get room => Get.arguments["room"];
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
    return room.listMessage.length + (isLastPage.value ? 0 : 1);
  }

  fetchData() async {
    isLoading.value = true;
    //TODO: fetch next fragment data when user scroll
    try {
      await Future.delayed(const Duration(seconds: 5));
      // final newMess = listMessageMock;
      final newMess = <Message>[];
      isLastPage.value = newMess.length < AppConstant.defaultPageSize;
      isLoading.value = false;
      pageNumber.value += 1;
      room.listMessage.insertAll(0, newMess);
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
    }
  }

  onSentMessage(BuildContext context) {
    var currentUser = AppManager().currentUser!;
    final newessage = Message.withContent(room.id,
        inputTextEditingController.text, User.fromAccount(currentUser));
    room.listMessage.add(newessage);
    inputTextEditingController.text = '';
    FocusScope.of(context).unfocus();
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  fetchDataWhenScroll() async {
    if (scrollController.offset <= scrollController.position.minScrollExtent) {
      await fetchData();
    }
  }
}
