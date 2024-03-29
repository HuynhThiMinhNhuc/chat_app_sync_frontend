import 'package:chat_app_sync/src/app/app_binding.dart';
import 'package:chat_app_sync/src/app/app_config/app_theme.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/app/app_routes/app_pages.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  final localDatasource = LocalDatasource();
  await Get.putAsync(() async {
    await localDatasource.ensureInitialized();
    return localDatasource;
  });
  runApp(const ChatAppSync());
}

class ChatAppSync extends StatelessWidget {
  const ChatAppSync({super.key});

  @override
  Widget build(BuildContext context) {
    // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
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

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     print("workmanager is start: $task");
//     switch (task) {
//       case AppConstant.sendMessageTask:
//         var res = await Get.find<NetworkDatasource>().sendMessage(inputData!);
//         if (res.isSuccess) {
//           var homeController = Get.find<HomePageController>();
//           var message = res.data!;
//           homeController.listChatRoom[message.roomId]?.listMessage.add(message);
//         }
//         break;
//       case AppConstant.getRoomTask:
//         var res = await Get.find<NetworkDatasource>().syncData(inputData!);
//         if (res.isSuccess) {
//           var homeController = Get.find<HomePageController>();
//           var items = res.data!["items"] as List<Map<String, dynamic>>;
//           var newMessages = <Message>[];
//           for (var item in items) {
//             homeController.receiveMessageOfRoom(ChatRoom.fromJson(item));
//           }
//         } else {
//           // TODO: do something
//         }
//         break;
//       default:
//         print("Not found task: $task");
//     }
//     return Future.value(true);
//   });
// }
