// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/helper/responsive_helper.dart';

class PhotoGridview extends StatelessWidget {
  final void Function()? ontap;
  final List<String>? gallery;
  final String? main;
  const PhotoGridview({super.key, this.main, this.gallery, this.ontap});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(6, (index) {
        if (index == 0) {
          return StaggeredGridTile.count(
            mainAxisCellCount: ResponsiveHelper.isSmallDevice() ? 1.9 : 2,
            crossAxisCellCount: 2,
            child: imageContainer(
                main ?? "https://i.ibb.co.com/nrs3FjM/images.png",
                'Main',
                false),
          );
        } else {
          bool hasImage = gallery != null && gallery!.length > index - 1;
          return GestureDetector(
            onTap: ontap,
            child: StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: imageContainer(hasImage ? gallery![index - 1] : "",
                  '${index + 0}', !hasImage),
            ),
          );
        }
      }),
    );
  }
}

Widget imageContainer(String image, String number, bool no) {
  return Container(
    height: 110.h,
    width: 140.w,
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.all(5.r),
    decoration: BoxDecoration(
        color:
            no ? const Color(0xffffffff).withOpacity(0.03) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: no
            ? Border.all(color: Colors.white.withOpacity(0.5), width: 1)
            : null,
        image: no
            ? null
            : DecorationImage(
                image: CachedNetworkImageProvider(image), fit: BoxFit.fill)),
    child: no
        ? Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15.r)),
            child: Center(
                child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                  width: 140.w,
                ),
                const Icon(Icons.add, color: Colors.white),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.r, horizontal: 10.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Text(
                      number,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            )))
        : Container(
            padding: EdgeInsets.symmetric(vertical: 3.r, horizontal: 10.r),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Text(
              number,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp),
            ),
          ),
  );
}
