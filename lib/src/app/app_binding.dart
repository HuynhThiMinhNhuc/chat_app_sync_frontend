import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/network/network.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:chat_app_sync/src/data/repository/room_repository.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // final apiProvider = Get.find<ApiProvider>();
    final networkDatasource = Get.find<NetworkDatasource>();
    final localDatasource = Get.find<LocalDatasource>();

    Get.put(UserRepository(
      networkDatasource: networkDatasource,
      localDatasource: localDatasource,
    ));
    Get.put(RoomRepository(
      networkDatasource: networkDatasource,
      localDatasource: localDatasource,
    ));
    Get.put(ChatRepository(
      networkDatasource: networkDatasource,
      localDatasource: localDatasource,
    ));
  }
}
