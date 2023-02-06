import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/common/widget/internet_image_widget.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/presentation/search_page/search_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          SizedBox(
            width: AppConstant.width,
            child: Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.sender.userName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        message.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
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
