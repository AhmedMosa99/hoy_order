import 'package:get/get.dart';
import 'package:social_increase/modules/auth/controller/auth.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
