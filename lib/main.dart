import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_notes/route/appRoutes.dart';
import 'package:flutter_notes/screens/splash/page/splash_page.dart';
import 'package:flutter_notes/services/Db.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Db.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // To
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        392.7,
        825.4,
      ),
      builder: () {
        return GetMaterialApp(
          title: "Notes",
          darkTheme: ThemeData(
            primaryColor: const Color(0xFF101B25),
            primaryColorLight: Colors.white.withOpacity(0.1),
            textTheme: const TextTheme(
                titleSmall: TextStyle(
                  color: Colors.white,
                ),
                titleMedium: TextStyle(
                  color: Colors.white,
                ),
                titleLarge: TextStyle(
                  color: Colors.white,
                )),
            scaffoldBackgroundColor: const Color(0xFF101B25),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Color(0xFF101B25),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white.withOpacity(0.1),
              foregroundColor: Colors.white,
              focusColor: Colors.white,
              elevation: 0,
            ),
          ),
          theme: ThemeData(
            primaryColor: const Color(0xFF101B25),
            primaryColorLight: Colors.white.withOpacity(0.1),
            textTheme: const TextTheme(
                titleSmall: TextStyle(
                  color: Colors.white,
                ),
                titleMedium: TextStyle(
                  color: Colors.white,
                ),
                titleLarge: TextStyle(
                  color: Colors.white,
                )),
            scaffoldBackgroundColor: const Color(0xFF101B25),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Color(0xFF101B25),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white.withOpacity(0.1),
              foregroundColor: Colors.white,
              focusColor: Colors.white,
              elevation: 0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashPage.routeName,
          getPages: AppRoutes.routes,
          defaultTransition: Transition.rightToLeft,
        );
      },
    );
  }
}
