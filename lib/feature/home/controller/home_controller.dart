import 'package:get/get.dart';

class HomeController extends GetxController {

  var selectedIndex = (-1).obs;
  RxBool isSelect = false.obs;
 

  void selectButton(int index) {
    selectedIndex.value = index;
    isSelect.value = true;
  }


}
