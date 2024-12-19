import 'package:get/get.dart';

class CityController extends GetxController {
  RxString selectedCity = 'Cartagena'.obs;
  RxBool arrowDown = true.obs;

  void toggleMethod() {
    arrowDown.value = !arrowDown.value;
  }

  void selectCity(String city) {
    selectedCity.value = city;
  }
}

final List<String> cities = [
  'Bogotá',
  'Medellín',
  'Cali',
  'Barranquilla',
  'Cartagena',
  'Cúcuta',
  'Bucaramanga',
  'Pereira',
  'Santa Marta',
  'Ibagué',
  'Manizales',
];
