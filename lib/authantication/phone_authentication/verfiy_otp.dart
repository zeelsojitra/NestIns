// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:e_com/authantication/phone_authentication/enter_mobile.dart';
import 'package:e_com/screens/fancy_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_screen/comman_container.dart';
import '../../common_screen/Comman_text.dart';
import '../../getx/controller.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  String? otp;
  bool isLoding = false;
  final Controller controller = Get.put(Controller());
  Future verifyOtp() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationCode!, smsCode: otp.toString());

      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen1(),
          ));
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Inavalid OTP",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: const Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              setState(() {
                otp = verificationCode;
              });
            }, // end onSubmit
          ),
          SizedBox(
            height: 40.sp,
          ),
          // GetBuilder<Controller>(
          //   builder: (controller) => controller.isLoding == true
          //       ? Center(child: CircularProgressIndicator())
          //       : Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 20, vertical: 20),
          //           child: CommanContainer(
          //             child: Center(
          //                 child: CommanText(
          //               text: "Send Otp",
          //               color: Colors.white,
          //               fontweight: FontWeight.bold,
          //               fontsize: 20,
          //             )),
          //             BorderRadius: BorderRadius.circular(40),
          //             height: 45.sp,
          //             width: double.infinity,
          //             color: Color(0xffB7E4C7),
          //             ontap: () {
          //               controller.updateLoader(true);
          //
          //               verifyotp();
          //             },
          //           ),
          //         ),
          // ),
          isLoding == false
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CommanContainer(
                    borderRadius: BorderRadius.circular(40),
                    height: 45.sp,
                    width: double.infinity,
                    color: const Color(0xffB7E4C7),
                    ontap: () {
                      log("hello");
                      setState(() {
                        isLoding = false;
                      });

                      const VerifyOtp();
                    },
                    child: const Center(
                        child: CommanText(
                      text: "Send Otp",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                  ))
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
