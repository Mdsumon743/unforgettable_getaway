import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoGridview extends StatelessWidget {
  const PhotoGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        StaggeredGridTile.count(
          mainAxisCellCount: 2,
          crossAxisCellCount: 2,
          child: imageContainer("assets/images/mian.png", 'Main', false),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: imageContainer("assets/images/main2.png", '2', false),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: imageContainer("assets/images/main3.png", '3', false),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: imageContainer("assets/images/main5.png", '4', false),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: imageContainer("assets/images/main5.png", '5', true),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: imageContainer("assets/images/main5.png", '6', true),
        ),
      ],
    );
  }
}

Widget imageContainer(String image, String number, bool no) {
  return Container(
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
            : DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
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
