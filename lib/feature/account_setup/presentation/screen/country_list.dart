import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class CountryListScreen extends StatelessWidget {
  CountryListScreen({super.key});

  final List<Map<String, String>> countries = [
    {'name': 'United States', 'flag': 'us'},
    {'name': 'United Kingdom', 'flag': 'gb'}, // Corrected flag code
    {'name': 'Canada', 'flag': 'ca'},
    {'name': 'Afghanistan', 'flag': 'af'},
    {'name': 'Albania', 'flag': 'al'},
    {'name': 'Algeria', 'flag': 'dz'},
    {'name': 'Andorra', 'flag': 'ad'},
    {'name': 'Angola', 'flag': 'ao'},
    {'name': 'Argentina', 'flag': 'ar'},
    {'name': 'Armenia', 'flag': 'am'},
    {'name': 'Australia', 'flag': 'au'},
    {'name': 'Austria', 'flag': 'at'},
    {'name': 'Azerbaijan', 'flag': 'az'},
    {'name': 'Bahamas', 'flag': 'bs'},
    {'name': 'Bahrain', 'flag': 'bh'},
    {'name': 'Bangladesh', 'flag': 'bd'},
    {'name': 'Barbados', 'flag': 'bb'},
    {'name': 'Belarus', 'flag': 'by'},
    {'name': 'Belgium', 'flag': 'be'},
    {'name': 'Belize', 'flag': 'bz'},
    {'name': 'Benin', 'flag': 'bj'},
    {'name': 'Bhutan', 'flag': 'bt'},
    {'name': 'Bolivia', 'flag': 'bo'},
    {'name': 'Bosnia and Herzegovina', 'flag': 'ba'},
    {'name': 'Botswana', 'flag': 'bw'},
    {'name': 'Brazil', 'flag': 'br'},
    {'name': 'Brunei Darussalam', 'flag': 'bn'},
    {'name': 'Bulgaria', 'flag': 'bg'},
    {'name': 'Burkina Faso', 'flag': 'bf'},
    {'name': 'Burundi', 'flag': 'bi'},
    {'name': 'Cabo Verde', 'flag': 'cv'},
    // More countries can be added here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country Flags"),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.separated(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            var country = countries[index];
            return index == 3
                ? Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " A",
                          style: textStyle(
                              16.sp, AppColors.mediumDarkGrey, FontWeight.w400),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            CountryFlag.fromCountryCode(
                              country['flag'] ?? '',
                              width: 25.w,
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              country['name'] ?? '',
                              style: textStyle(
                                16.sp,
                                AppColors.darkBrown1,
                                FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : ListTile(
                  contentPadding: const EdgeInsets.all(0),
                    leading: CountryFlag.fromCountryCode(
                      country['flag'] ?? '',
                      width: 25.w,
                      height: 20.h,
                    ),
                    title: Text(country['name'] ?? ''),
                  );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: AppColors.semiTransparent,
              thickness: 0.5.sp,
            );
          },
        ),
      ),
    );
  }
}
