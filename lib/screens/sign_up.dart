import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_Container.dart';
import 'package:e_com/common_screen/Comman_TeextFiled.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../authantication/email authantication/EmailAuthService.dart';
import '../globle/variable.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> with SingleTickerProviderStateMixin {
  final Email_controler = TextEditingController();
  final usernamecontroler = TextEditingController();
  final Password_controler = TextEditingController();
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
              Comman_TexxtFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: usernamecontroler,
                hinttext: "Enter Name",
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
                        color: black,
                      )
                    : SizedBox(),
                prefixicon: Icon(
                  Icons.person_outlined,
                  size: 20.sp,
                  color: grey,
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
                sufficicon: Email_controler.text.length == 10
                    ? Icon(
                        Icons.check_circle,
                        color: black,
                      )
                    : SizedBox(),
                prefixicon: Icon(
                  Icons.email,
                  size: 20.sp,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Comman_TexxtFiled(
                filled: true,
                fillcolor: Colors.grey.shade200,
                controller: Password_controler,
                obscureText: true,
                hinttext: "Enter password",
                validator: (value) {
                  final bool passwordValid = password.hasMatch(value!);

                  if (value.isEmpty) {
                    return "Enter Password";
                  } else if (passwordValid != true) {
                    return "please enter valid password";
                  }
                },
                onChanged: (value) {},
                prefixicon: Icon(
                  Icons.lock,
                  size: 20.sp,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              contoller.signuploder == false
                  ? Center(
                      child: Comman_Container(
                        borderRadius: BorderRadius.circular(40),
                        ontap: () {
                          print("signuploder frist ${contoller.signuploder}");
                          if (gloablekey.currentState!.validate()) {
                            // controller.signuploder = true.obs;
                            print("Signuploder true ${contoller.signuploder}");
                            EmailAuthService.SignupUser(
                                    email: Email_controler.text,
                                    password: Password_controler.text)
                                .then((value) async {
                              if (value != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Successfully SignUp Plz Login App"),
                                  ),
                                );

                                FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({
                                  "profile_image": "",
                                  "profile_name": usernamecontroler.text,
                                  "profile_email": Email_controler.text,
                                  "favourite": [],
                                  "buyNow": [],
                                });
                                contoller.signuploder = false.obs;
                                print(
                                    "Signuploder false after create databace ${contoller.signuploder}");
                                usernamecontroler.clear();
                                Email_controler.clear();
                                Password_controler.clear();
                              } else {
                                contoller.signuploder = false.obs;
                                print(
                                    "singuploder last ${contoller.signuploder}");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Email is Alerdy Use by Anthor Account"),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        height: 35.sp,
                        width: 140.sp,
                        color: LightGreen,
                        child: Center(
                          child: Comman_Text(
                            text: "Sign Up",
                            color: white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
