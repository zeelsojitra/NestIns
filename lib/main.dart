import 'package:e_com/screens/RoadMap/RoadMap_Screen.dart';
import 'package:e_com/screens/CategoriesScreen.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'bottom_Navigation/bottom_NAV.dart';
import 'globle/shardpefrence.dart';

void main() async {
  ///milan
  // main ma koy pen change kerva mate aa line lakhvi j pade.
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //horizontal oriantaion lock kerva mate.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //safearea color kerva mate.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black54,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        title: 'NestIn',
        // theme: MyThemes.lightTheme,
        // darkTheme: MyThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: Splash_Screen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
// class MyThemes {
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor: Colors.grey.shade900,
//     colorScheme: ColorScheme.dark(),
//   );
//   static final lightTheme = ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     colorScheme: ColorScheme.light(),
//   );
// }
