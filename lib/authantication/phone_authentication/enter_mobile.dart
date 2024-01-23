import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:e_com/authantication/phone_authentication/verfiy_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../common_screen/comman_container.dart';
import '../../common_screen/comman_textformfeild.dart';
import '../../common_screen/Comman_text.dart';

String? phone;
String? verificationCode;

class EnterMobile extends StatefulWidget {
  const EnterMobile({super.key});

  @override
  State<EnterMobile> createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  String countryCode = "91";
  String countryFlage = "";
  final phoneno = TextEditingController();
  final gloablekey = GlobalKey<FormState>();
  Future sendOtpService() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneno.text}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CommanText(
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
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: gloablekey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'asserts/image/bg.png',
                fit: BoxFit.cover,
                height: height * 0.3,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CommanText(
                  color: Colors.grey,
                  text:
                      "Please enter your phone number to\nverify your account",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CommanTextFormFiled(
                  keyboardType: TextInputType.phone,
                  labletext: "Enter Number",
                  hinttext: "Enter number",
                  controller: phoneno,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plz Enter Number";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      gloablekey.currentState!.validate();
                    });
                  },
                  sufficicon: phoneno.text.length == 10
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const SizedBox(),
                  prefixicon: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 0, right: 10),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight:
                                500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              countryCode = country.phoneCode;
                              countryFlage = country.flagEmoji;
                            });
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("+$countryCode"),
                          Text(countryFlage.isEmpty ? "" : countryFlage),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommanContainer(
                  ontap: () {
                    if (gloablekey.currentState!.validate()) {
                      log("validation");
                      sendOtpService().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerifyOtp(),
                          ),
                        ),
                      );
                    }
                  },
                  height: 45.sp,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffB7E4C7),
                  child: const Center(
                    child: CommanText(
                      text: "Send Verification Code",
                      fontSize: 18,
                      color: Colors.white,
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
