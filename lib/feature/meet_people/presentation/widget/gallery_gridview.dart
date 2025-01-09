import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_inter.dart';

class GalleryGridview extends StatelessWidget {
  final List image;
  const GalleryGridview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 200.r),
      child: GridView.builder(
        itemCount: image.length,
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.9 / 0.75,
        ),
        itemBuilder: (context, index) {
          var data = image[index];
          if (image.isEmpty) {
            return Center(
              child: CustomTextIner(
                text: "No Images",
                fontWeight: FontWeight.w600,
                size: 20.sp,
                color: Colors.white,
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image:
                      DecorationImage(image: CachedNetworkImageProvider(data))),
            );
          }
        },
      ),
    );
  }
}
