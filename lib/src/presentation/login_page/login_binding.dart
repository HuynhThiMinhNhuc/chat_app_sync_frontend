 import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:chat_app_sync/src/presentation/login_page/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    final userRepository = Get.find<UserRepository>();
    Get.lazyPut<LoginController>(() => LoginController(userRepository));
  }

}