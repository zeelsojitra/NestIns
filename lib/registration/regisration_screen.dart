// ignore_for_file: unnecessary_string_interpolations

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';
import 'otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String verify = "";
  static String username = "";
  static String mobile = "";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String country = "indian";
  String countryCodee = "91";
  String countryFlag = "";
  final phoneNo = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? verificationCode;
  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  Future sendOtpService() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneNo.text}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Comman_Text(
              text: error.message.toString(),
            ),
          ),
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: Get.width * 0.05,
          left: Get.width * 0.05,
          top: Get.height * 0.12,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  main_logo,
                  height: Get.height * 0.2,
                ),
                SizedBox(height: Get.height * 0.03),
                Text(
                  "Phone Verification",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height * 0.038),
                ),
                SizedBox(height: Get.height * 0.03),
                Text(
                  "We need to register your phone before getting started!",
                  style: TextStyle(fontSize: Get.height * 0.022),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.03),
                TextFormField(
                  controller: userName,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (userName.text.isEmpty) {
                      return "Please Enter Your Name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userName.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Name"),
                ),
                SizedBox(height: Get.height * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone Number can't be Empty!";
                    } else if (value.length < 10) {
                      return "Enter must be 10 Digits";
                    }
                  },
                  controller: phoneNo,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  countryCodee = country.phoneCode;
                                  countryFlag = country.flagEmoji;
                                });
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(countryFlag.isEmpty ? "" : countryFlag),
                              SizedBox(
                                width: 5,
                              ),
                              Text("+${countryCodee}"),
                              Text("  |", textScaleFactor: 2),
                            ],
                          ),
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      counterText: "",
                      hintText: "Enter your number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                // SizedBox(height: Get.height * 0.02),
                // Container(
                //   height: Get.height * 0.065,
                //   decoration: BoxDecoration(
                //     border:
                //         Border.all(width: 1, color: Colors.purpleAccent),
                //     borderRadius: BorderRadius.circular(Get.height * 0.02),
                //   ),
                //   child: Row(
                //     children: [
                //       SizedBox(width: Get.width * 0.035),
                //       SizedBox(
                //         width: Get.height * 0.045,
                //         child: TextFormField(
                //           controller: countryCode,
                //           textInputAction: TextInputAction.next,
                //           decoration: const InputDecoration(
                //               border: InputBorder.none),
                //           onSaved: (newValue) =>
                //               countryCode.text = newValue!,
                //         ),
                //       ),
                //       Text(
                //         "|",
                //         style: TextStyle(
                //             fontSize: Get.height * 0.04,
                //             color: Colors.purpleAccent,
                //             fontWeight: FontWeight.w300),
                //       ),
                //       SizedBox(width: Get.height * 0.02),
                //       Expanded(
                //         child: TextFormField(
                //           controller: mobile,
                //           keyboardType: TextInputType.number,
                //           validator: (value) {
                //             if (userName.text.isEmpty) {
                //               return "Please Enter Your Number";
                //             }
                //             return null;
                //           },
                //           onSaved: (value) {
                //             mobile.text = value!;
                //           },
                //           textInputAction: TextInputAction.done,
                //           decoration: const InputDecoration(
                //               border: InputBorder.none,
                //               hintText: "Mobile Number"),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: Get.height * 0.035),
                SizedBox(
                  height: Get.height * 0.07,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   await FirebaseAuth.instance.verifyPhoneNumber(
                      //     phoneNumber: "${countryCode.text + mobile.text}",
                      //     verificationCompleted:
                      //         (PhoneAuthCredential credential) {},
                      //     verificationFailed: (FirebaseAuthException e) {
                      //       Fluttertoast.showToast(msg: "Auth Failed!");
                      //     },
                      //     codeSent:
                      //         (String verificationId, int? resendToken) async {
                      //       Get.to(OTPScreen());
                      //       Fluttertoast.showToast(msg: "OTP Sent :)");
                      //       RegistrationScreen.verify = verificationId;
                      //       RegistrationScreen.username = userName.text;
                      //       RegistrationScreen.mobile = mobile.text;
                      //     },
                      //     codeAutoRetrievalTimeout: (String verificationId) {
                      //       Fluttertoast.showToast(msg: "Timeout!");
                      //     },
                      //   );
                      // }
                      sendOtpService().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DarkGreen2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Send   The Code",
                      style: TextStyle(fontSize: Get.height * 0.02),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithPhone() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, "otp");
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${countryCode.text + mobile.text}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: "Auth Failed!");
        },
        codeSent: (String verificationId, int? resendToken) async {
          Fluttertoast.showToast(msg: "OTP Sent :)");
          RegistrationScreen.verify = verificationId;
          RegistrationScreen.username = userName.text;
          RegistrationScreen.mobile = mobile.text;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(msg: "Timeout!");
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    countryCode.dispose();
    userName.dispose();
    mobile.dispose();
  }
}
