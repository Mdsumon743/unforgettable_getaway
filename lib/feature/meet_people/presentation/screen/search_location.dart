import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/meet_people.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: const Column(
              children: [
                CustomTextFieldSearch(
                  keyboardType: TextInputType.text,
                  hintText: 'Search for people by city ',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff737268),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldSearch extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color? color;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFieldSearch({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.color,
    this.fillColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldSearchState createState() => _CustomTextFieldSearchState();
}

class _CustomTextFieldSearchState extends State<CustomTextFieldSearch> {
  List<String> citiesAndCountries = [
    "New York, USA",
    "London, UK",
    "Paris, France",
    "Tokyo, Japan",
    "Sydney, Australia",
    "Berlin, Germany",
    "Moscow, Russia",
    "Toronto, Canada",
    "São Paulo, Brazil",
    "Delhi, India",
    "Shanghai, China",
    "Seoul, South Korea",
    "Mexico City, Mexico",
    "Rome, Italy",
    "Cairo, Egypt"
  ];
  List<String> filteredSuggestions = [];

  void _filterSuggestions(String query) {
    setState(() {
      filteredSuggestions = citiesAndCountries
          .where((cityCountry) =>
              cityCountry.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.fillColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: const Color(0xff737268), width: 1.5),
            ),
            child: TextFormField(
              textInputAction: widget.textInputAction,
              onChanged: _filterSuggestions,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              validator: widget.validator,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: widget.color ?? const Color(0xff333329),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: widget.color ?? const Color(0xff333329),
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
              ),
            ),
          ),
          filteredSuggestions.isNotEmpty
              ? Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      // shrinkWrap: false,
                      primary: false,
                      itemCount: filteredSuggestions.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredSuggestions[index]),
                          onTap: () {
                            widget.controller?.text =
                                filteredSuggestions[index];
                            Get.to(() => const MeetPeople());
                          },
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
