import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/screens/sign_in.dart';
import 'package:e_com/screens/sign_up.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../authantication/google auth service/google_auth_service.dart';
import '../bottom_Navigation/bottom_navi_demo.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../common_screen/loding.dart';
import '../globle/variable.dart';

class Tab_Bar extends StatefulWidget {
  const Tab_Bar({Key? key}) : super(key: key);

  @override
  State<Tab_Bar> createState() => _Tab_BarState();
}

class _Tab_BarState extends State<Tab_Bar> with SingleTickerProviderStateMixin {
  TabController? tabController;

  final gloablekey = GlobalKey<FormState>();
  final Email_controler = TextEditingController();
  final Password_controler = TextEditingController();
  List name = [
    'Sign Up',
    'Sign In',
  ];
  List tabItem = [
    "Sign Up",
    "Sign In",
  ];
  int selected = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    tabController!.addListener(() {
      setState(() {
        selected = tabController!.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.055),
            Image.asset(
              main_logo,
              height: Get.height * 0.15,
            ),
            Text(
              "E-mail Verification",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Get.height * 0.038,
                  fontFamily: "JS1"),
            ),
            SizedBox(height: Get.height * 0.015),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "We need to register your E-mail before getting started!",
                style:
                    TextStyle(fontSize: Get.height * 0.022, fontFamily: "JV1"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Comman_Container(
              child: Column(
                children: [
                  Container(
                    child: TabBar(
                      labelPadding: EdgeInsets.symmetric(
                          horizontal: 20.sp, vertical: 10.sp),
                      controller: tabController,
                      indicatorColor: Color(0xff2D6A4F),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 25.sp),
                      tabs: List.generate(
                        2,
                        (index) => Center(
                          child: Comman_Text(
                            text: name[index],
                            //fontFamily: "JM1",
                            fontSize: 16.sp,
                            color: selected == index
                                ? Color(0xff2D6A4F)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Comman_Container(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    height: 273.sp,
                    width: 500.sp,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Sign_Up(),
                        Sign_In(),
                      ],
                    ),
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  offset: Offset(2, 2),
                  blurRadius: 7,
                )
              ],
              height: 322.sp,
              width: 270.sp,
            ),
            SizedBox(height: 20.sp),
            Center(
              child: Comman_Text(
                text: "Or Sign In With",
                color: Colors.grey,
                //////fontFamily: "JV1",
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Enter_mobile(),
                //         ));
                //   },
                //   child: Container(
                //     height: 38.sp,
                //     width: 38.sp,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey,
                //           blurRadius: 1,
                //           offset: Offset(2, 3),
                //           spreadRadius: 1,
                //         )
                //       ],
                //     ),
                //     child: Lottie.asset(
                //       "asserts/lottie/calling.json",
                //       width: 27.sp,
                //       height: 27.sp,
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LodingDiloge(
                          message: "",
                        );
                      },
                    );

                    GoogleAuthService.signInWithGoogle().then((value) async {
                      if (value != null) {
                        Get.back();
                        Get.off(Bottom_navigation());
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          "profile_image": "",
                          "profile_name": profile_name,
                          "profile_email": profile_email,
                          "favourite": [],
                          "buyNow": [],
                          "add to cart": [],
                          "User_id": FirebaseAuth.instance.currentUser!.uid,
                        });
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        await sharedPreferences.setBool(
                            Splash_ScreenState.KeyValue, true);
                        await sharedPreferences.setString(
                            "profile_name", profile_name!);
                        await sharedPreferences.setString(
                            "profile_email", profile_email!);
                      } else {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Email is already in use by another accoount"),
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(2, 3),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    height: 38.sp,
                    width: 38.sp,
                    child: Center(
                      child: Lottie.asset(
                        'asserts/lottie/google.json',
                        height: 27.sp,
                        width: 27.sp,
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text("Invalid User!")));
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey,
                //           blurRadius: 1,
                //           offset: Offset(2, 3),
                //           spreadRadius: 1,
                //         )
                //       ],
                //     ),
                //     height: 38.sp,
                //     width: 38.sp,
                //     child: Center(
                //       child: Lottie.asset(
                //         'asserts/lottie/apple.json',
                //         height: 27.sp,
                //         width: 27.sp,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
