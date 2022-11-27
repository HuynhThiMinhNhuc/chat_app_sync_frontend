import 'package:chat_app_sync/src/app/app_routes/app_routes.dart';
import 'package:chat_app_sync/src/common/widget/alert_dialog_widget.dart';
import 'package:chat_app_sync/src/repositories/user_repository.dart';
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

  onLogin() async {
    if (formKey.currentState == null) {
      AlertDialogWidget.show();
    } else if (formKey.currentState!.validate()) {
      final loginRes = await userRepository.login(
          userNameTextEditingController.text,
          passwordTextEditingController.text);
      if (loginRes.isSuccess()) {
        Get.toNamed(AppRoutes.homePage);
      } else {
        AlertDialogWidget.show(content: loginRes.message);
      }
    }
  }
}
