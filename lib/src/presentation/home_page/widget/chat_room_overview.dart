import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OverviewChatRoom extends StatelessWidget {
  final Rx<ChatRoom> chatRoom;
  final void Function()? onTap;
  const OverviewChatRoom({Key? key, required this.chatRoom, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: AppConstant.width,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(chatRoom.avatarUri.value ??
                      'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
                  radius: 25.r,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatRoom.name.value,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Obx(() => Text(
                            chatRoom.lastMessage?.content ??
                                'Chưa có tin nhắn nào',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Divider(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
            thickness: 0.3,
          ),
          SizedBox(
            height: 8.h,
          )
        ],
      ),
    );
  }
}
