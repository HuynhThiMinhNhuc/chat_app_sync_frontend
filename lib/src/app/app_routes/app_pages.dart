import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/presentation/chat_room/chat_room_binding.dart';
import 'package:chat_app_sync/src/presentation/chat_room/chat_room_page.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page_binding.dart';
import 'package:chat_app_sync/src/presentation/login_page/login_binding.dart';
import 'package:chat_app_sync/src/presentation/login_page/login_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.homePage,
        page: () => const HomePage(),
        binding: HomePageBinding()),
    GetPage(
        name: AppRoutes.chatRoom,
        page: () => const ChatRoomPage(),
        binding: ChatRoomBinding())
  ];
}
