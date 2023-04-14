// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:sizer/sizer.dart';
//
// class VerifyMobile extends StatefulWidget {
//   const VerifyMobile({Key? key}) : super(key: key);
//
//   @override
//   State<VerifyMobile> createState() => _VerifyMobileState();
// }
//
// class _VerifyMobileState extends State<VerifyMobile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image(
//                 image: AssetImage('assets/images/zeel_logo.png'),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
//               child: Text(
//                 "Please enter Code sent to",
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Text(
//                     "+91 123 456 7890",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   Text(
//                     "Change phone Number",
//                     style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       fontSize: 14,
//                       color: Color(0xff2D6A4F),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             // OTPTextField(
//             //   length: 4,
//             //   width: MediaQuery.of(context).size.width,
//             //   fieldWidth: 70,
//             //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             //   textFieldAlignment: MainAxisAlignment.spaceEvenly,
//             //   fieldStyle: FieldStyle.underline,
//             //   onCompleted: (pin) {
//             //     print("Completed: " + pin);
//             //   },
//             // ),
//             OtpTextField(
//               numberOfFields: 6,
//               borderColor: Color(0xFF512DA8),
//               //set to true to show as box or false to show as dash
//               showFieldAsBox: true,
//               //runs when a code is typed in
//               onCodeChanged: (String code) {
//                 //handle validation or checks here
//               },
//               //runs when every textfield is filled
//               onSubmit: (String verificationCode) {
//                 setState(() {
//                   OTP = verificationCode;
//                 });
//               }, // end onSubmit
//             ),
//             SizedBox(
//               height: 50.sp,
//             ),
//             Center(
//               child: MaterialButton(
//                 height: 35.sp,
//                 minWidth: 250.sp,
//                 textColor: Colors.white,
//                 child: Text("Send Verification Code"),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DemoZeel(),
//                       ));
//                 },
//                 shape: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide: BorderSide.none),
//                 color: Color(0xff95D5B2),
//                 // text: "Send Verification Code",
//                 // textcolor: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: Text(
//                 "Skip",
//                 style: TextStyle(fontSize: 18, color: Color(0xff2D6A4F)),
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
