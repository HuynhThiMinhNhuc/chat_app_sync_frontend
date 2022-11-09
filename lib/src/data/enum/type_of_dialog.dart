import 'package:chat_app_sync/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TypeOfDialog { success, warning, error }

extension TypeOfDialogExt on TypeOfDialog {
  String get iconPath {
    switch (this) {
      case TypeOfDialog.error:
        return "assets/images/illustration/error_icon.png";
      case TypeOfDialog.warning:
        return "assets/images/illustration/warning_icon.png";
      default:
        return "assets/images/illustration/success_icon.png";
    }
  }

  String get title {
    switch (this) {
      case TypeOfDialog.error:
        return "error".tr;
      case TypeOfDialog.warning:
        return "warning".tr;
      default:
        return "success".tr;
    }
  }

  Color getTextColor(BuildContext context) {
    switch (this) {
      case TypeOfDialog.error:
        return Theme.of(context).errorColor;
      case TypeOfDialog.warning:
        return Theme.of(context).highlightColor;
      default:
        return Theme.of(context).backgroundColor;
    }
  }

  ButtonStyle getButtonStyle(BuildContext context) {
    switch (this) {
      case TypeOfDialog.error:
        return CommonStyle.outlinedButtonStyle(context: context);
      case TypeOfDialog.warning:
        return CommonStyle.outlinedButtonStyle(
            context: context, color: Theme.of(context).highlightColor);
      default:
        return CommonStyle.containedButtonStyle(context: context);
    }
  }
}
