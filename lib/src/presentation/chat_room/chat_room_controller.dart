import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/data/enum/message_status.dart';
import 'package:chat_app_sync/src/data/message.dart';
import 'package:chat_app_sync/src/data/mock/message.dart';
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
  final listMessage = [
    Message(
        conttent: 'hi dddkjhdkjkjdhksssssssssssssssssssssssssj',
        messageStatus: MessageStatus.viewed,
        isSender: true),
    Message(
        conttent: 'hello',
        messageStatus: MessageStatus.viewed,
        isSender: false),
    Message(
        conttent: 'How are you?',
        messageStatus: MessageStatus.viewed,
        isSender: true),
    Message(
        conttent: 'fine', messageStatus: MessageStatus.viewed, isSender: false),
    Message(
        conttent: 'bye', messageStatus: MessageStatus.viewed, isSender: true),
    Message(
        conttent: 'hi dddkjhdkjkjdhksssssssssssssssssssssssssj',
        messageStatus: MessageStatus.viewed,
        isSender: true),
    Message(
        conttent: 'hello',
        messageStatus: MessageStatus.viewed,
        isSender: false),
    Message(
        conttent: 'How are you?',
        messageStatus: MessageStatus.viewed,
        isSender: true),
    Message(
        conttent: 'fine', messageStatus: MessageStatus.viewed, isSender: false),
    Message(
        conttent: 'bye', messageStatus: MessageStatus.viewed, isSender: true),
    Message(
        conttent: 'hi dddkjhdkjkjdhksssssssssssssssssssssssssj',
        messageStatus: MessageStatus.viewed,
        isSender: true),
    Message(
        conttent: 'hello',
        messageStatus: MessageStatus.viewed,
        isSender: false),
    Message(
        conttent: 'How are you?',
        messageStatus: MessageStatus.viewed,
        isSender: true),
    Message(
        conttent: 'fine', messageStatus: MessageStatus.viewed, isSender: false),
    Message(
        conttent: 'bye', messageStatus: MessageStatus.viewed, isSender: true)
  ].obs;

 
  getListMessLength(){
    return listMessage.length + (isLastPage.value ? 0 :1);
  }

  fetchData() async {
    isLoading.value = true;
    //TODO: fetch next fragment data when user scroll
    try {
      await Future.delayed(const Duration(seconds: 5));
      final newMess = listMessageMock;
      isLastPage.value = newMess.length < AppConstant.pageSize;
      isLoading.value = false;
      pageNumber.value +=1;
      listMessage.insertAll(0, newMess);
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
    }
  }

  onSentMessage(BuildContext context) {
    final newessage =
        Message(conttent: inputTextEditingController.text, isSender: true);
    listMessage.add(newessage);
    inputTextEditingController.text = '';
    FocusScope.of(context).unfocus();
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  fetchDataWhenScroll() async{
    if (scrollController.offset <=
            scrollController.position.minScrollExtent ) {
      await fetchData();
    }
  }


}
