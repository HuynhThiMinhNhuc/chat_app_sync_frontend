import 'package:chat_app_sync/src/common/widget/internet_image_widget.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/presentation/search_page/search_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Anna Nguyen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Obx(() => controller.result.isNotEmpty
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  '${controller.result.length} matched message',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 12.h,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.result.length,
                    itemBuilder: ((context, index) =>
                        SearchResultWidget(message: controller.result[index])))
              ])
            : Text(
                'No matched message',
                style: Theme.of(context).textTheme.bodyText1,
              )),
      ),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InternetImageWidget(
                    imgUrl: message.sender.imageUri,
                    width: 52.r,
                    height: 52.r,
                    borderRadius: 100.r,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.sender.userName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        message.content,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
              Stack(children: [
                Icon(
                  FontAwesomeIcons.solidMoon,
                  color: Theme.of(context).errorColor,
                  size: 45.r,
                ),
                Icon(
                  FontAwesomeIcons.solidCommentDots,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 30.r,
                ),
              ])
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Divider(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
          ),
          SizedBox(
            height: 8.h,
          )
        ],
      ),
    );
  }
}
