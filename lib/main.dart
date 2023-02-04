import 'package:chat_app_sync/src/app/app_binding.dart';
import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_config/app_theme.dart';
import 'package:chat_app_sync/src/app/app_routes/app_pages.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/network/network.dart';
import 'package:chat_app_sync/src/presentation/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import 'src/common/network/api_provider.dart';
import 'src/data/local/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiProvider = ApiProvider();
  final networkDatasource = NetworkDatasource(apiProvider);
  final localDatasource = LocalDatasource();
  await localDatasource.ensureInitialized();

  // AppBinding().dependencies();
  await ScreenUtil.ensureScreenSize();
  runApp(ChatAppSync(
    apiProvider: apiProvider,
    localDatasource: localDatasource,
    networkDatasource: networkDatasource,
  ));
}

class ChatAppSync extends StatelessWidget {
  late final ApiProvider apiProvider;
  late final NetworkDatasource networkDatasource;
  late final LocalDatasource localDatasource;

  ChatAppSync({super.key, 
    required ApiProvider apiProvider,
    required NetworkDatasource networkDatasource,
    required LocalDatasource localDatasource,
  }){
    this.apiProvider = Get.put(apiProvider);
    this.networkDatasource = Get.put(networkDatasource);
    this.localDatasource = Get.put(localDatasource);
  }

  @override
  Widget build(BuildContext context) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    return ScreenUtilInit(
        builder: ((context, child) => GetMaterialApp(
              title: 'Chat app sync',
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fade,
              initialBinding: AppBinding(),
              getPages: AppPages.routes,
              initialRoute: AppRoutes.login,
              theme: lightTheme,
            )));
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("workmanager is start: $task");
    switch (task) {
      case AppConstant.sendMessageTask:
        var res = await Get.find<NetworkDatasource>().sendMessage(inputData!);
        if (res.isSuccess) {
          var homeController = Get.find<HomePageController>();
          var message = res.data!;
          homeController.listChatRoom[message.roomId]?.listMessage.add(message);
        }
        break;
      case AppConstant.getRoomTask:
        var res = await Get.find<NetworkDatasource>().syncData(inputData!);
        if (res.isSuccess) {
          var homeController = Get.find<HomePageController>();
          var items = res.data!["items"] as List<Map<String, dynamic>>;
          var newMessages = <Message>[];
          for (var item in items) {
            homeController.receiveMessageOfRoom(ChatRoom.fromJson(item));
          }
        } else {
          // TODO: do something
        }
        break;
      default:
        print("Not found task: $task");
    }
    return Future.value(true);
  });
}
