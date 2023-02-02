import 'package:chat_app_sync/src/presentation/chat_room/chat_room_controller.dart';
import 'package:chat_app_sync/src/presentation/chat_room/widget/chat_input_field.dart';
import 'package:chat_app_sync/src/presentation/chat_room/widget/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatRoomPage extends GetView<ChatRoomController> {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Hoang Sang',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Theme.of(context).errorColor,
            Theme.of(context).secondaryHeaderColor
          ]))),
          actions: [
            IconButton(
                onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'Search in conversation',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .backgroundColor),
                                ),
                                content: TextField(
                                  controller:
                                      controller.searchTextEditingController,
                                  onChanged: controller.onChangeKeySearch,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'Cancel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .errorColor),
                                      )),
                                  Obx(() => TextButton(
                                      onPressed:
                                          controller.searchKey.value.isNotEmpty
                                              ? controller.onNavigateSearchPage
                                              : null,
                                      child: Text(
                                        'Search',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: controller.searchKey
                                                        .value.isNotEmpty
                                                    ? Theme.of(context)
                                                        .backgroundColor
                                                    : Theme.of(context)
                                                        .hintColor),
                                      )))
                                ],
                              ))
                    },
                icon: Icon(
                  Icons.search,
                  size: 24.r,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(children: [
            SizedBox(
              height: 16.h,
            ),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: const CircularProgressIndicator())),
            Obx((() => _builtMessageView())),
            ChatInputField(
              controller: controller.inputTextEditingController,
              onSendMess: () => controller.onSentMessage(context),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _builtMessageView() {
    if (controller.room.value.listMessage.isEmpty) {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.all(8.r),
          child: const CircularProgressIndicator(),
        );
      }
      if (controller.isError.value) {
        return const Text('error');
      }
    }
    return Expanded(
        child: Obx(() => ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.room.value.listMessage.length,
            itemBuilder: (context, index) {
              return MessageWidget(
                  message: controller.room.value.listMessage[index]);
            })));
  }
}
