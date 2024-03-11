import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/view/authantication/email_authantication/email_auth_service.dart';
import 'package:e_com/src/view/authantication/google_auth_service/google_auth_service.dart';
import 'package:e_com/src/view/bottom_Navigation/bottom_navi_demo.dart';
import 'package:e_com/src/view/splash_screen.dart';
import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:e_com/src/widgets/comman_textformfeild.dart';
import 'package:e_com/src/widgets/loding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String countryCode = "91";
  String countryFlage = "";
  final usernamecontroler = TextEditingController();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  bool passwordcheck = true;
  int selected = 0;
  bool isLoding = false;
  List name = [
    'Sign Up',
    'Sign In',
  ];
  final gloablekey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: gloablekey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 17.sp,
              ),
              CommanTextFormFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: usernamecontroler,
                hinttext: "Enter Name",
                hintfontFamily: "JV1",
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
                sufficicon: usernamecontroler.text.length > 2
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.black,
                      )
                    : const SizedBox(),
                prefixicon: Icon(
                  Icons.person_outlined,
                  size: 20.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              CommanTextFormFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: emailControler,
                hinttext: "Enter Email",
                hintfontFamily: "JV1",
                fontFamily: "JV1",
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
                prefixicon: const Icon(
                  Icons.email,
                  size: 20,
                  color: Colors.grey,
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
                hintfontFamily: "JV1",
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
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Center(
                child: CommanContainer(
                  borderRadius: BorderRadius.circular(40),
                  ontap: () {
                    log("hello");
                    if (gloablekey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const LodingDiloge(
                            message: "",
                          );
                        },
                      );
                      EmailAuthService.loginUser(
                              password: passwordControler.text,
                              email: emailControler.text)
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
                            "User_id": FirebaseAuth.instance.currentUser!.uid,
                          });
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          await sharedPreferences.setBool(
                              SplashScreenState.keyValue, true);
                          await sharedPreferences.setString(
                              "profile_name", usernamecontroler.text);
                          await sharedPreferences.setString(
                              "profile_email", emailControler.text);
                        } else {
                          Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invalid Email or Password!"),
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
                      text: "Sign In",
                      //fontFamily: "JV1",
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
