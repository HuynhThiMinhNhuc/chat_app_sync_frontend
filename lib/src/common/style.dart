import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonStyle{
  static InputDecoration outlineTextFieldSyle({String? hintText = "", required BuildContext context}){
    return  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.r),
                            borderSide: BorderSide(
                                color: Theme.of(context).scaffoldBackgroundColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.r),
                            borderSide: BorderSide(
                                color: Theme.of(context).scaffoldBackgroundColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.r),
                            borderSide: BorderSide(
                                color: Theme.of(context).scaffoldBackgroundColor),
                          ),
                          hintText: hintText ?? '',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor));
  }
  static ButtonStyle outlinedButtonStyle(
      {Color? color , required BuildContext context}) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
          Theme.of(context).textTheme.button?.copyWith(color: color) ??
              TextStyle(fontSize: 14.sp, color: color)),
      backgroundColor:
          MaterialStateProperty.all<Color>(Theme.of(context).backgroundColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: color ?? Theme.of(context).scaffoldBackgroundColor, width: 1))),
    );
  }
    static ButtonStyle containedButtonStyle(
      {
      required BuildContext context}) {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.w),
        )),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.transparent),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero));
  }


}