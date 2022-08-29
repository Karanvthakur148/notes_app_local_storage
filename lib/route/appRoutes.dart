import 'package:flutter_notes/route/appBindings.dart';
import 'package:flutter_notes/screens/addNote/page/addNotePage.dart';
import 'package:flutter_notes/screens/home/page/homePage.dart';
import 'package:flutter_notes/screens/splash/page/splash_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: SplashPage.routeName,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AddNotePage.routeName,
      page: () => const AddNotePage(),
    )
  ];
}
