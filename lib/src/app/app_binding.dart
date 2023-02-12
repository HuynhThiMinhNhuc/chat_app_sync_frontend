import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:chat_app_sync/src/common/socket/socket.dart';
import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/network/network.dart';
import 'package:chat_app_sync/src/data/repository/chat_repository.dart';
import 'package:chat_app_sync/src/data/repository/room_repository.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    final apiProvider = ApiProvider();
    final networkDatasource = NetworkDatasource(apiProvider);
    final localDatasource = Get.find<LocalDatasource>();
    final socket = SocketService();

    Get.put(apiProvider);
    Get.put(networkDatasource);
    Get.put(socket);

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
