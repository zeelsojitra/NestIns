import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/authantication/email_authantication/email_auth_service.dart';
import 'package:e_com/common_screen/comman_textformfeild.dart';
import 'package:e_com/common_screen/comman_text.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../authantication/google_auth_service/google_auth_service.dart';
import '../bottom_navigation/bottom_navi_demo.dart';
import '../common_screen/comman_container.dart';
import '../common_screen/loding.dart';
import '../globle/variable.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final emailControler = TextEditingController();
  final userNameControler = TextEditingController();
  final passwordControler = TextEditingController();
  bool passwordcheck = true;
  int selected = 0;
  //bool signuploder = false;
  List name = [
    'Sign Up',
    'Sign In',
  ];
  TabController? tabController;
  final gloablekey = GlobalKey<FormState>();
  List tabItem = [
    "Sign Up",
    "Sign In",
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Form(
          key: gloablekey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 17.sp,
              ),
              CommanTextFormFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: userNameControler,
                hinttext: "Enter Name",
                hintfontFamily: "JM1",
                fontFamily: "JV1",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Name";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    gloablekey.currentState!.validate();
                  });
                },
                sufficicon: userNameControler.text.length > 2
                    ? const Icon(
                        Icons.check_circle,
                        color: black,
                      )
                    : const SizedBox(),
                prefixicon: Icon(
                  Icons.person_outlined,
                  size: 20.sp,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              CommanTextFormFiled(
                fontFamily: "JV1",
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: emailControler,
                hinttext: "Enter Email",
                hintfontFamily: "JM1",
                validator: (value) {
                  final bool emailValid = email.hasMatch(value!);

                  if (emailValid) {
                    return null;
                  } else {
                    return "Please enter valid Email Id";
                  }
                },
                onChanged: (value) {
                  gloablekey.currentState!.validate();
                },
                sufficicon: emailControler.text.length == 10
                    ? const Icon(
                        Icons.check_circle,
                        color: black,
                      )
                    : const SizedBox(),
                prefixicon: Icon(
                  Icons.email,
                  size: 20.sp,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              CommanTextFormFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: passwordControler,
                obscureText: passwordcheck,
                sufficicon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordcheck = !passwordcheck;
                    });
                  },
                  icon: passwordcheck
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                hinttext: "Enter password",
                hintfontFamily: "JM1",
                fontFamily: "JV1",
                validator: (value) {
                  final bool passwordValid = password.hasMatch(value!);

                  if (value.isEmpty) {
                    return "Enter Password";
                  } else if (passwordValid != true) {
                    return "please enter valid password";
                  }
                  return null;
                },
                onChanged: (value) {
                  gloablekey.currentState!.validate();
                },
                prefixicon: Icon(
                  Icons.lock,
                  size: 20.sp,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              contoller.signuploder.value == false
                  ? Center(
                      child: CommanContainer(
                        borderRadius: BorderRadius.circular(40),
                        ontap: () {
                          log("signuploder frist ${contoller.signuploder}");
                          if (gloablekey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const LodingDiloge(
                                  message: "",
                                );
                              },
                            );
                            // controller.signuploder = true.obs;
                            log("Signuploder true ${contoller.signuploder}");
                            EmailAuthService.signupUser(
                                    email: emailControler.text,
                                    password: passwordControler.text)
                                .then((value) async {
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
                                  "User_id":
                                      FirebaseAuth.instance.currentUser!.uid,
                                });
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setBool(
                                    SplashScreenState.keyValue, true);
                                await sharedPreferences.setString(
                                    "profile_name", userNameControler.text);
                                await sharedPreferences.setString(
                                    "profile_email", emailControler.text);
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
                          }
                        },
                        height: 35.sp,
                        width: 140.sp,
                        color: lightGreen,
                        child: Center(
                          child: CommanText(
                            text: "Sign Up",
                            color: white,
                            //fontFamily: "JM1",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
