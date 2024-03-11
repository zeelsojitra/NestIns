import 'package:e_com/src/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => const GetMaterialApp(
        title: 'NestIn',
        // theme: MyThemes.lightTheme,
        // darkTheme: MyThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
