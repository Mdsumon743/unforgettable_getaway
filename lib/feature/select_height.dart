import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';

class SelectHeight extends StatefulWidget {
  const SelectHeight({super.key});

  @override
  State<SelectHeight> createState() => _SelectHeightState();
}

class _SelectHeightState extends State<SelectHeight> {
  late FixedExtentScrollController _controller;
    
  List<String>? heightsCm = [
    "5.5''",
    "5.6''",
    "5.7''",
    "5.8''",
    "5.4''",
    "5.3''",
    "5.2''",
    "5.1''",
    "5.9''",
    "5.0''",
  ];
  String currentState = "5.4''";

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView.useDelegate(
          itemExtent: 50,
          perspective: 0.003,
          diameterRatio: 1.9,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() {
              currentState = index.toString();
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
              childCount: heightsCm?.length,
              builder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: currentState == index.toString()
                        ? AppColors.mediumDarkGrey.withOpacity(0.4)
                        : null,
                    gradient: currentState != index.toString()
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF99997A).withOpacity(0.3),
                              const Color(0xFF333329),
                            ],
                            // stops: const [0.3, 1.0],
                          )
                        : null,
                  ),
                  child: Text(
                    heightsCm?[index]??'',
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                );
              })),
    );
  }
}
