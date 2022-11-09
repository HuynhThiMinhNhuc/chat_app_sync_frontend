import 'package:chat_app_sync/src/data/enum/type_of_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AlertDialogWidget extends StatelessWidget {
  final TypeOfDialog type;
  final String content;
  final String textButton;
  final List<Widget>? actions;
  final VoidCallback? onPressButton;
  final String? title;
  const AlertDialogWidget(
      {Key? key,
      this.type = TypeOfDialog.success,
      required this.content,
      required this.textButton,
      this.onPressButton,
      this.actions,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  type.iconPath,
                  height: 120.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  title ?? type.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ElevatedButton(
                  onPressed: onPressButton,
                  style: type.getButtonStyle(context),
                  child: Text(
                    textButton,
                    style: TextStyle(color: type.getTextColor(context)),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  static void hideDialog() {
    if (Get.isDialogOpen == null) return;
    if (Get.isDialogOpen!) Get.back();
  }

  static void show(
      {bool? barrierDismissible,
      String? content,
      String? title,
      String? textButton,
      VoidCallback? onPress,
      TypeOfDialog? typeOfDialog}) {
    Get.dialog(
        barrierDismissible: barrierDismissible ?? true,
        AlertDialogWidget(
          title: title,
          content: content ?? 'systerm_error'.tr,
          textButton: textButton ?? 'confirm'.tr,
          onPressButton: onPress ?? Get.back,
          type: typeOfDialog ?? TypeOfDialog.error,
        ));
  }
}
