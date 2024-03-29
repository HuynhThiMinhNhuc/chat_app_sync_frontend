import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/common/socket/socket.dart';
import 'package:chat_app_sync/src/common/widget/alert_dialog_widget.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController(this.userRepository);

  final UserRepository userRepository;
  final userNameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    AppManager().setup().then((_) async {
      if (AppConstant.isClearCache) {
        await AppManager().cleanData();
      }
      if (AppManager().isSignIn()) {
        var success = await AppManager().tryLogIn();
        if (success) {
          await Get.toNamed(AppRoutes.homePage);
        }
      }
    });
  }

  //Validation
  String? onValidationUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_user_name'.tr;
    }
    return null;
  }

  String? onValidationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_password'.tr;
    }
    return null;
  }

  Future<void> onLogin() async {
    if (formKey.currentState == null) {
      AlertDialogWidget.show();
    } else if (formKey.currentState!.validate()) {
      try {
        final loginRes = await userRepository.login(
            userNameTextEditingController.text,
            passwordTextEditingController.text);
        AppManager().saveKeyAndCurrentInfor(loginRes, loginRes.token);
        final socket = Get.find<SocketService>();
        socket.connect();
        socket.emitLogin(loginRes.token);
        // Navigate to home page
        Get.toNamed(AppRoutes.homePage);
      } catch (e) {
        AlertDialogWidget.show(content: e.toString());
      }
    }
  }
}
