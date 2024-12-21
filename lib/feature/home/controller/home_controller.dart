import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';

class HomeController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  var selectedIndex = (-1).obs;
  RxBool isSelect = false.obs;
  RxBool isAccount = true.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
    isSelect.value = true;
  }

  saveValue() async {
    await preferencesHelper.init();
    preferencesHelper.setBool("FirstTime", isAccount.value);
  }

  @override
  void onInit() {
    super.onInit();
    saveValue();
  }
}
