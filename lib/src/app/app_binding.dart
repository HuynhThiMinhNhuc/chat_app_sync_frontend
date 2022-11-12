import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    final apiProvider = ApiProvider();
    Get.put(apiProvider);
  }
  
}