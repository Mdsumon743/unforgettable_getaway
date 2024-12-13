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
          child: imageContainer("assets/images/mian.png", 'Main'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: imageContainer("assets/images/main2.png", '2'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child:  imageContainer("assets/images/main3.png", '3'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child:  imageContainer("assets/images/main5.png", '4'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: Colors.deepPurple,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}

Widget imageContainer(String image, String number) {
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.all(5.r),
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 3.r, horizontal: 10.r),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
      child: Text(
        number,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.sp),
      ),
    ),
  );
}
