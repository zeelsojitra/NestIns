import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/screens/sign_in.dart';
import 'package:e_com/screens/sign_up.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../authantication/google_auth_service/google_auth_service.dart';
import '../bottom_navigation/bottom_navi_demo.dart';

import '../common_screen/Comman_text.dart';
import '../common_screen/comman_container.dart';
import '../common_screen/loding.dart';
import '../globle/variable.dart';

class TabBarScreenH extends StatefulWidget {
  const TabBarScreenH({super.key});

  @override
  State<TabBarScreenH> createState() => _TabBarScreenHState();
}

class _TabBarScreenHState extends State<TabBarScreenH>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final gloablekey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.055),
            Image.asset(
              mainLogo,
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
            CommanContainer(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  offset: Offset(2, 2),
                  blurRadius: 7,
                )
              ],
              height: 322.sp,
              width: 270.sp,
              child: Column(
                children: [
                  TabBar(
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 10.sp),
                    controller: tabController,
                    indicatorColor: const Color(0xff2D6A4F),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 25.sp),
                    tabs: List.generate(
                      2,
                      (index) => Center(
                        child: CommanText(
                          text: name[index],
                          //fontFamily: "JM1",
                          fontSize: 16.sp,
                          color: selected == index
                              ? const Color(0xff2D6A4F)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  CommanContainer(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    height: 273.sp,
                    width: 500.sp,
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        SignUp(),
                        SignIn(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            Center(
              child: CommanText(
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
                        return const LodingDiloge(
                          message: "",
                        );
                      },
                    );

                    GoogleAuthService.signInWithGoogle().then((value) async {
                      if (value != null) {
                        Get.back();
                        Get.off(const BottomNavigation());
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          "profile_image": "",
                          "profile_name": profileName,
                          "profile_email": profileEmail,
                          "favourite": [],
                          "buyNow": [],
                          "add to cart": [],
                          "User_id": FirebaseAuth.instance.currentUser!.uid,
                        });
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        await sharedPreferences.setBool(
                            SplashScreenState.keyValue, true);
                        await sharedPreferences.setString(
                            "profile_name", profileName!);
                        await sharedPreferences.setString(
                            "profile_email", profileEmail!);
                      } else {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Email is already in use by another accoount"),
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
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
