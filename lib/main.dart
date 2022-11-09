import 'package:chat_app_sync/src/app/app_binding.dart';
import 'package:chat_app_sync/src/app/app_config/app_theme.dart';
import 'package:chat_app_sync/src/app/app_routes/app_pages.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const ChatAppSync());
}

class ChatAppSync extends StatelessWidget {
  const ChatAppSync({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:((context, child) =>  GetMaterialApp(
        title: 'Chat app sync',
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fade,
        initialBinding: AppBinding(),
        getPages: AppPages.routes,
        initialRoute: AppRoutes.login,
        theme: lightTheme, 
       ))
    );
  }
}

