import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/data/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {Key? key, required this.message})
      : super(key: key);

   final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isSender != null && message.isSender!
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          margin: EdgeInsets.fromLTRB(0, 4.h, 0.w, 4.h),
          width: AppConstant.width / 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: message.isSender != null && message.isSender!
                    ? Radius.circular(10.r)
                    : Radius.zero,
                topRight: message.isSender != null && message.isSender!
                    ? Radius.zero
                    : Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              gradient: message.isSender != null && message.isSender!
                  ? LinearGradient(colors: [
                      Theme.of(context).errorColor,
                      Theme.of(context).secondaryHeaderColor
                    ])
                  : null),
          child: Text(
            message.conttent ?? '',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: message.isSender != null && message.isSender!
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).canvasColor),
          ),
        ),
      ],
    );
  }
}