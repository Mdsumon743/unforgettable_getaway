import 'package:get/get.dart';
import 'controller.dart';


class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }

}