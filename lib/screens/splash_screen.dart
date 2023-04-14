import 'dart:async';
import 'package:e_com/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';
import 'bottom_navigation_screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => Splash_ScreenState();
}

class Splash_ScreenState extends State<Splash_Screen> {
  Future Getusername() async {
    var sh = await SharedPreferences.getInstance();
    var IsLoggedIn = sh.getBool(KeyValue);

    Timer(Duration(seconds: 2), () {
      if (IsLoggedIn != null) {
        if (IsLoggedIn) {
          Get.off(Bottom_navigation());
        } else {
          Get.off(On_Boarding());
        }
      } else {
        Get.off(On_Boarding());
      }
    });
  }

  static const String KeyValue = "Login";
  @override
  void initState() {
    Getusername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Comman_Container(
            height: Get.height,
            width: Get.width,
            gradient: LinearGradient(colors: [
              DarkGreen2,
              LightGreen,
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    height: 100.sp,
                    width: 100.sp,
                    image: AssetImage(SplashAppLogowhite),
                  ),
                ),
                SizedBox(
                  height: 7.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Comman_Text(
                      text: "Nest",
                      color: black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    // SizedBox(
                    //   width: 5.sp,
                    // ),
                    Comman_Text(
                      text: "In",
                      color: black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
