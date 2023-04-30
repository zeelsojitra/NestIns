import 'package:e_com/common_screen/Comman_Container.dart';
import 'package:e_com/common_screen/Comman_TeextFiled.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:e_com/globle/shardpefrence.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../authantication/email authantication/EmailAuthService.dart';
import '../bottom_Navigation/bottom_NAV.dart';
import '../bottom_Navigation/bottom_navi_demo.dart';
import '../common_screen/loding.dart';
import '../globle/variable.dart';
import 'bottom_navigation_screen.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({Key? key}) : super(key: key);

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  String countryCode = "91";
  String countryFlage = "";
  final usernamecontroler = TextEditingController();
  final Email_controler = TextEditingController();
  final Password_controler = TextEditingController();
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
              Comman_TexxtFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: usernamecontroler,
                hinttext: "Enter Name",
                HintfontFamily: "JM1",
                fontFamily: "JV1",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Name";
                  }
                },
                onChanged: (value) {
                  setState(() {
                    gloablekey.currentState!.validate();
                  });
                },
                sufficicon: usernamecontroler.text.length > 2
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.black,
                      )
                    : SizedBox(),
                prefixicon: Icon(
                  Icons.person_outlined,
                  size: 20.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Comman_TexxtFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: Email_controler,
                hinttext: "Enter Email",
                HintfontFamily: "JM1",
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
                prefixicon: Icon(
                  Icons.email,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Comman_TexxtFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: Password_controler,
                obscureText: passwordcheck,
                sufficicon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordcheck = !passwordcheck;
                    });
                  },
                  icon: passwordcheck
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
                hinttext: "Enter password",
                HintfontFamily: "JM1",
                fontFamily: "JV1",
                validator: (value) {
                  final bool passwordValid = password.hasMatch(value!);

                  if (value.isEmpty) {
                    return "Enter Password";
                  } else if (passwordValid != true) {
                    return "please enter valid password";
                  }
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
                child: Comman_Container(
                  borderRadius: BorderRadius.circular(40),
                  ontap: () {
                    print("hello");
                    setState(() {
                      if (gloablekey.currentState!.validate()) {
                        String? name, email;
                        name = usernamecontroler.text;
                        email = Email_controler.text;
                        EmailAuthService.LoginUser(
                                password: Password_controler.text,
                                email: Email_controler.text)
                            .then((value) async {
                          if (value != null) {
                            SharedPreferences sh =
                                await SharedPreferences.getInstance();
                            Email_controler.clear();
                            Password_controler.clear();
                            sh
                                .setBool(Splash_ScreenState.KeyValue, true)
                                .whenComplete(
                                  () => Get.off(Bottom_navigation()),
                                );
                            await sharedPreferences!
                                .setString("profile_email", email!);
                            await sharedPreferences!
                                .setString("profile_name", name!);
                          } else {
                            setState(() {
                              isLoding = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Comman_Text(
                              text: "Invalid Email or Password",
                            )));
                          }
                        });
                      }
                    });
                  },
                  height: 35.sp,
                  width: 140.sp,
                  color: LightGreen,
                  child: Center(
                    child: Comman_Text(
                      text: "Sign In",
                      fontFamily: "JM1",
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
