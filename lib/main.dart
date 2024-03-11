import 'package:e_com/src/app.dart';
import 'package:e_com/src/constant/shardpefrence.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  ///milan
  // main ma koy pen change kerva mate aa line lakhvi j pade.
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //horizontal oriantaion lock kerva mate.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //safearea color kerva mate.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black54,
  ));
  runApp(const MyApp());
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
