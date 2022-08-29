import 'package:flutter_notes/screens/home/page/homePage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(HomePage.routeName);
    super.onInit();
  }
}
