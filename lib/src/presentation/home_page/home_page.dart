import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page_controller.dart';
import 'package:chat_app_sync/src/presentation/home_page/widget/chat_room_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text(
            'Chat list',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        body: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          color: Theme.of(context).scaffoldBackgroundColor,
          onRefresh: () =>
              Future.sync(() => controller.paggingController.refresh()),
          child: PagedListView<int, Rx<ChatRoom>>(
              pagingController: controller.paggingController,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              builderDelegate: PagedChildBuilderDelegate<Rx<ChatRoom>>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => OverviewChatRoom(
                  chatRoom: item.value,
                  onTap: () => controller.onTapOverViewChat(item),
                ),
              )),
        ));
  }
}
