import 'package:chat_app_sync/src/data/repository/room_repository.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    final roomRepository = Get.find<RoomRepository>();
    Get.lazyPut<HomePageController>(() => HomePageController(roomRepository));
  }

}