import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/view/authantication/google_auth_service/google_auth_service.dart';
import 'package:e_com/src/view/bottom_Navigation/bottom_navi_demo.dart';
import 'package:e_com/src/view/sign_in.dart';
import 'package:e_com/src/view/sign_up.dart';
import 'package:e_com/src/view/splash_screen.dart';
import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:e_com/src/widgets/loding.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CommanContainer(
                    height: 220.sp,
                    width: double.infinity,
                    gradient: const LinearGradient(colors: [
                      darkGreen2,
                      lightGreen,
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: 15.sp,
                              left: 15.sp,
                              top: 15.sp,
                              bottom: 5.sp),
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.green,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_outlined,
                                  size: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 15.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommanText(
                                text: "Shipping and Track Anytime ",
                                color: white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              CommanText(
                                text: "Get great experience with tracky",
                                color: white70,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 30.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 120.sp, right: 25, left: 25),
                    child: CommanContainer(
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
                      height: 320.sp,
                      width: 260.sp,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.sp,
                          ),
                          TabBar(
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 20.sp, vertical: 10.sp),
                            controller: tabController,
                            indicatorColor: const Color(0xff2D6A4F),
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 25.sp),
                            tabs: List.generate(
                              2,
                              (index) => Center(
                                child: CommanText(
                                  text: name[index],
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
                            height: 270.sp,
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
                  ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              Center(
                child: CommanText(
                  text: "Or Sign In With",
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 20.sp,
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
                            // "profile_image": profile_image,
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
                          // await sharedPreferences.setString(
                          //     "profile_image", profile!);
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
              SizedBox(
                height: 30.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
