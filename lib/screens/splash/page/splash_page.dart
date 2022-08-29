import 'package:flutter/material.dart';
import 'package:flutter_notes/appConfigs/appImages.dart';
import 'package:flutter_notes/screens/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.logo,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
