import 'package:chat_app_sync/src/presentation/chat_room/chat_room_controller.dart';
import 'package:get/get.dart';

class ChatRoomBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(() => ChatRoomController());
  }

}