import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String lable;

  const ButtonWidget(
      {Key? key,
      this.onPressed,
      required this.lable,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:  BoxConstraints(minWidth: AppConstant.width),
        child: ElevatedButton(
          style: CommonStyle.containedButtonStyle(context: context),
          onPressed: onPressed,
          child: Ink(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
             decoration:  BoxDecoration(
      gradient: LinearGradient(colors: [
        Theme.of(context).errorColor,
        Theme.of(context).secondaryHeaderColor
        
      ], ),
      borderRadius: BorderRadius.all(Radius.circular(80.r)),
    ),
            child: Center(
              child: Text(
                lable,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ));
  }
}
