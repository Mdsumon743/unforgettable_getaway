import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryGridview extends StatelessWidget {
  const GalleryGridview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/pic1.png",
      "assets/images/pic2.png",
      "assets/images/pic3.png",
      "assets/images/pic4.png",
      "assets/images/pic5.png",
    ];
    return GridView.builder(
      itemCount: images.length,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7 / 0.7,
      ),
      itemBuilder: (context, index) {
        var data = images[index];
        return Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(image: AssetImage(data))),
        );
      },
    );
  }
}
