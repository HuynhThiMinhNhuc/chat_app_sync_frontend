import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OverviewChatRoom extends StatelessWidget {
  final ChatRoom chatRoom;
  final void Function()? onTap;
  const OverviewChatRoom({
    Key? key,
    required this.chatRoom,
     this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(chatRoom.avatarUri ??
                            'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
                        radius: 25.r,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatRoom.name,
                            style:
                                Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            chatRoom.lastMessage?.content ?? 'Chưa có tin nhắn nào',
                            style:
                                Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      )
                    ],
                  ),
                  Stack(children: [
                     Icon(FontAwesomeIcons.solidMoon,  color:
                          Theme.of(context).errorColor,
                      size: 45.r,),
                    Icon(
                      FontAwesomeIcons.solidCommentDots,
                      color:
                          Theme.of(context).scaffoldBackgroundColor,
                      size: 30.r,
                    ),
                   
                  ])
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Divider(
                color: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.2),
              ),
              SizedBox(
                height: 8.h,
              )
            ],
          ),
    );
  }
}
