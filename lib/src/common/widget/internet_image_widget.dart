import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InternetImageWidget extends StatelessWidget {
  final String? imgUrl;
  final double width;
  final double height;
  final double borderRadius;
  final String replaceImgUrl;
  final BoxFit fit;
  final double circularProgressIndicatorRadius;
  final EdgeInsets? padding;

  const InternetImageWidget(
      {super.key,
      required this.imgUrl,
      this.borderRadius = 10,
      this.width = 60,
      this.height = 60,
      this.padding,
      this.replaceImgUrl = 'assets/images/avatar.jpeg',
      this.fit = BoxFit.cover,
      this.circularProgressIndicatorRadius = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(8.r),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: imgUrl != null && imgUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imgUrl!,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    height: circularProgressIndicatorRadius,
                    width: circularProgressIndicatorRadius,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: fit,
              )
            : Image.asset(
                replaceImgUrl,
                fit: fit,
              ),
      ),
    );
  }
}
