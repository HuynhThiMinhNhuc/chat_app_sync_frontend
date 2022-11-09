import 'package:chat_app_sync/src/common/style.dart';
import 'package:chat_app_sync/src/common/widget/button_widget.dart';
import 'package:chat_app_sync/src/presentation/login_page/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage("assets/images/login_background.jpg"),
                isAntiAlias: true,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor.withOpacity(0.6),
                    BlendMode.srcOver),
                fit: BoxFit.fitHeight)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login on MetAnon',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Login to your account',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) =>
                              controller.onValidationUserName(value),
                          controller: controller.userNameTextEditingController,
                          decoration: CommonStyle.outlineTextFieldSyle(
                              context: context,
                              hintText: 'Enter your user name'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          validator: (value) =>
                              controller.onValidationPassword(value),
                          controller: controller.passwordTextEditingController,
                          decoration: CommonStyle.outlineTextFieldSyle(
                              context: context,
                              hintText: 'Enter your password'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ButtonWidget(
                          lable: 'Login',
                          onPressed: controller.onLogin,
                        )
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
