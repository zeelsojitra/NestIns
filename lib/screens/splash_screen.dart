import 'dart:async';
import 'package:e_com/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_navigation/bottom_navi_demo.dart';
import '../common_screen/comman_container.dart';
import '../globle/variable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Future getusername() async {
    var sh = await SharedPreferences.getInstance();
    var isLoggedIn = sh.getBool(keyValue);

    Timer(const Duration(seconds: 2), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Get.off(const BottomNavigation());
        } else {
          Get.off(const OnBoarding());
        }
      } else {
        Get.off(const OnBoarding());
      }
    });
  }

  static const String keyValue = "Login";
  @override
  void initState() {
    getusername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommanContainer(
            height: Get.height,
            width: Get.width,
            color: black,
            // gradient: LinearGradient(colors: [
            //   lightGreen,
            //   darkGreen2,
            // ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: Get.height * 0.55,
                  width: Get.width * 0.55,
                  image: const AssetImage(logoGreen),
                ),
                // SizedBox(
                //   height: 7.sp,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CommanText(
                //       text: "Nest",
                //       color: white,
                //       fontSize: 30.sp,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     // SizedBox(
                //     //   width: 5.sp,
                //     // ),
                //     CommanText(
                //       text: "In",
                //       color: white,
                //       fontSize: 30.sp,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
