import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/city_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/country_selection_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/height_selection_screen.dart';

class AccountController extends GetxController {
  RxInt genderSelectedValue = 0.obs;
  RxInt heightSelectedIndex = 2.obs;
  RxList favoriteList = [].obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  
  RxInt userAge = 0.obs;
  TextEditingController nameEditingController = TextEditingController();
  final countryController = Get.put(CountrySelectionController());
  final cityController = Get.put(CityController());

  Future<void> selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1988),
        lastDate: DateTime(2101),
        // initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: type == 'date'
            ? DatePickerMode.day
            : type == 'year'
                ? DatePickerMode.year
                : DatePickerMode.day);
    if (picked != null) {
      selectedDate.value = picked;
    }
    userAge.value = calculateAgeInYearsMonthsDays();
  }

  void showNumberDialog(BuildContext context, Function(int) onNumberSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Month'),
          content: SizedBox(
            width: 20.w,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 300.h), 
              child: ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${index + 1}'),
                    onTap: () {
                      onNumberSelected(index + 1);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  int calculateAgeInYearsMonthsDays() {
    final DateTime currentDate = DateTime.now();

    int years = currentDate.year - selectedDate.value!.year;

    if (currentDate.month < selectedDate.value!.month ||
        (currentDate.month == selectedDate.value!.month &&
            currentDate.day < selectedDate.value!.day)) {
      years--;
    }

    int months = currentDate.month - selectedDate.value!.month;
    if (months < 0) {
      months += 12;
    }

    int days = currentDate.day - selectedDate.value!.day;
    if (days < 0) {
      final previousMonth = DateTime(currentDate.year, currentDate.month, 0);
      days += previousMonth.day;
    }

    debugPrint('Age: $years years, $months months, $days days');
    return years;
  }

  void updatedValueGender(int value) {
    genderSelectedValue.value = value;
    debugPrint(genderSelectedValue.value.toString());
  }

  void selectHeight(int index) {
    heightSelectedIndex.value = index;
    debugPrint(heights[index]);
    debugPrint(heightSelectedIndex.value.toString());
  }

  void addFavoritList(String interestItem) {
    favoriteList.add(interestItem);
  }

  void saveUserInformation() {
    String country = countryController.selectedCountry;
    String city = cityController.selectedCity.value;
    String name = nameEditingController.text;
    String day = selectedDate.value?.day.toString() ?? '';
    String month = selectedDate.value?.month.toString() ?? '';
    String year = selectedDate.value?.year.toString() ?? '';
    String gender = genderSelectedValue.value == 0 ? 'Woman' : 'Men';
    String height = heights[heightSelectedIndex.value];
    List userfavoriteList = favoriteList;
    debugPrint(userfavoriteList.toString());
    // Map<String, dynamic> userInformation= {

    // }
  }
}
