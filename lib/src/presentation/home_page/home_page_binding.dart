import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:chat_app_sync/src/data/repository/room_repository.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    final roomRepository = Get.find<RoomRepository>();
    final chatRepository = Get.find<ChatRepository>();
    final userRepository = Get.find<UserRepository>();
    Get.lazyPut<HomePageController>(() => HomePageController(roomRepository, chatRepository, userRepository));
  }

}