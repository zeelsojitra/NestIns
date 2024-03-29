// ignore_for_file: use_build_context_synchronously
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/view/authantication/phone_authentication/enter_mobile.dart';
import 'package:e_com/src/view/bottom_Navigation/bottom_navi_demo.dart';
import 'package:e_com/src/view/fancy_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:kudrati_kahumbo/model/user_model.dart';
// import 'package:kudrati_kahumbo/screen/auth/regisration_screen.dart';
// import 'package:kudrati_kahumbo/utils/dimensions.dart';
// import 'package:pinput/pinput.dart';
// import '../../helper/helper_function.dart';
// import '../../utils/app_colors.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var pinCode = "";
  String? otp;
  Future verifyotp() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationCode!, smsCode: otp.toString());

      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        ),
      );
      //Get.toEnd(() => Bottom_navigation());
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("INVALID OTP"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: const TextStyle(
    //       fontSize: 20,
    //       color: Color.fromARGB(255, 255, 255, 255),
    //       fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: const Color.fromARGB(255, 178, 176, 178)),
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: purple),
    //   borderRadius: BorderRadius.circular(8),
    // );

    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: purple,
    //   ),
    // );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asserts/logo/textLogo.png",
                ),
                const SizedBox(height: 15),
                const Text(
                  "phone Verification",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We need to register your phone before getting started !",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Text(
                //   "Your No is ${RegistrationScreen.mobile.substring(0, 3)}*****${RegistrationScreen.mobile.substring(8)} ?",
                //   style: TextStyle(fontSize: 18, color: purple),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 15),
                // Pinput(
                //   length: 6,
                //   defaultPinTheme: defaultPinTheme,
                //   focusedPinTheme: focusedPinTheme,
                //   submittedPinTheme: submittedPinTheme,
                //   androidSmsAutofillMethod:
                //       AndroidSmsAutofillMethod.smsRetrieverApi,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please Enter OTP";
                //     }
                //     return null;
                //   },
                //   onChanged: (value) {
                //     pinCode = value;
                //   },
                //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                //   showCursor: true,
                // ),
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
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      verifyotp().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen1(),
                          ),
                        ),
                      );
                      // if (_formKey.currentState!.validate()) {
                      //   try {
                      //     PhoneAuthCredential credential =
                      //         PhoneAuthProvider.credential(
                      //             verificationId: RegistrationScreen.verify,
                      //             smsCode: pinCode);
                      //     await auth
                      //         .signInWithCredential(credential)
                      //         .then((value) async {
                      //       postDetailsToFirestore();
                      //       await HelperFunction.saveLogingData(true);
                      //       Navigator.pushNamedAndRemoveUntil(
                      //           context, "home", (route) => false);
                      //     });
                      //   } on FirebaseAuthException {
                      //     Fluttertoast.showToast(
                      //         msg: "Otp Wrong !", textColor: Colors.red);
                      //   }
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Verify phone Number",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "registration", (route) => false);
                    },
                    child: const Text(
                      "Edit phone Number ?",
                      style: TextStyle(color: darkGreen2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   postDetailsToFirestore() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = auth.currentUser;
//     UserModel userModel = UserModel();
//     userModel.mobile = user?.phoneNumber;
//     userModel.uid = user?.uid;
//     userModel.c_name = RegistrationScreen.username;
//     await firebaseFirestore
//         .collection("customer")
//         .doc(user!.uid)
//         .set(userModel.toMap());
//   }
}
