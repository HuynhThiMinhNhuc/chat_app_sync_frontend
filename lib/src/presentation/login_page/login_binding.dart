 import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:chat_app_sync/src/presentation/login_page/login_controller.dart';
import 'package:chat_app_sync/src/repositories/user_repository.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    final apiProvider = Get.find<ApiProvider>();
    final userRepository = UserRepository(apiProvider);
    Get.lazyPut<LoginController>(() => LoginController(userRepository));
  }

}