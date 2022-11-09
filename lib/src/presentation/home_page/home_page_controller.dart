import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/data/chat_room.dart';
import 'package:chat_app_sync/src/data/message.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageController extends GetxController{
  final paggingController = PagingController<int, ChatRoom>(firstPageKey: 0);

  //TODO: Get list chatroom from server
  final listChatRoom = [
    ChatRoom(id: '0',
    avatar: 'https://plus.unsplash.com/premium_photo-1663127025797-782798d6faf4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTV8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    name: 'Lauren German',
    listMessage: [Message(conttent: 'Bye bye!')]
    ),
    ChatRoom(id: '0',
    avatar: 'https://images.unsplash.com/photo-1624561187289-198fc6eee90b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjB8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    name: 'Rachel Harris',
    listMessage: [Message(conttent: 'Bye bye!')]
    ),
    ChatRoom(id: '0',
    avatar: 'https://images.unsplash.com/photo-1624561272659-224ea122b2e9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Njd8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    name: 'Kevin Rankin',
    listMessage: [Message(conttent: 'Bye bye!')]
    ),
    ChatRoom(id: '0',
    avatar: 'https://plus.unsplash.com/premium_photo-1663100703769-61c87c264693?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODN8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    name: 'Tom Ellis',
    listMessage: [Message(conttent: 'Bye bye!')]
    )
  ];

  @override
  void onInit() {
    paggingController.addPageRequestListener((pageKey) { 
      fectchPage(pageKey);
    });
    if (!ifLastPage(listChatRoom.length)){
      paggingController.appendPage(listChatRoom, 1);
    }
    else{
      paggingController.appendLastPage(listChatRoom);
    }
    super.onInit();
  }

  onTapOverViewChat(ChatRoom chatRoom){
    Get.toNamed(AppRoutes.chatRoom, arguments: chatRoom);
  }

  bool ifLastPage(int lenght) => lenght < AppConstant.pageSize;

  fectchPage(int pageKey) {
     //TODO: Get next list chat room 
  }
}