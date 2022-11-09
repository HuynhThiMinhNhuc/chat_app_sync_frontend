import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
    required this.controller,
    required this.onSendMess
  }) : super(key: key);

  final TextEditingController controller;
  final void Function()? onSendMess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: SafeArea(
          child: Row(
        children: [
          Expanded(
              child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.05)),
            child: Row(children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextFormField(
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  decoration: InputDecoration(
                      hintText: 'write your message',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.3)),
                      border: InputBorder.none),
                ),
              ))
            ]),
          )),
          SizedBox(
            width: 12.w,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                  Theme.of(context).errorColor,
                  Theme.of(context).secondaryHeaderColor
                ])),
            child: IconButton(
                onPressed: onSendMess,
                icon: Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Theme.of(context).scaffoldBackgroundColor,
                )),
          )
        ],
      )),
    );
  }
}
