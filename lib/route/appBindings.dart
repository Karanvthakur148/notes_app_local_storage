import 'package:flutter_notes/screens/addNote/controller/addNoteController.dart';
import 'package:flutter_notes/screens/home/controller/homeController.dart';
import 'package:flutter_notes/screens/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AddNoteController());
  }
}
