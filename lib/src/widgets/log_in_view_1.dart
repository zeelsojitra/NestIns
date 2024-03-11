// import 'package:flutter/material.dart';
//
// import 'globle/media_query.dart';
//
// class LoginInEcom extends StatefulWidget {
//   const LoginInEcom({Key? key}) : super(key: key);
//
//   @override
//   State<LoginInEcom> createState() => _LoginInEcomState();
// }
//
// class _LoginInEcomState extends State<LoginInEcom> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff0f0f0),
//       appBar: AppBar(
//         backgroundColor: Color(0xff95D5B2),
//         leading: InkWell(
//           onTap: () {},
//           child: Icon(Icons.arrow_back, size: 30, color: Colors.black),
//         ),
//       ),
//       body: Column(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 height: height(context) / 3.1,
//                 width: width(context),
//                 decoration: BoxDecoration(
//                   color: Color(0xff2D6A4F),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Shipping and Track Anytime",
//                         style: TextStyle(
//                             fontSize: height(context) / 31,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       SizedBox(
//                         height: height(context) * 0.02,
//                       ),
//                       Text(
//                         "Get great experience with tracky",
//                         style: TextStyle(
//                           fontSize: height(context) / 41,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context) / 5,
//                 left: width(context) / 12,
//                 child: Container(
//                   height: height(context) / 1.7,
//                   width: width(context) / 1.2,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey, spreadRadius: 1, blurRadius: 6),
//                     ],
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(top: 20, right: 20, left: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Email",
//                             style: TextStyle(
//                               color: Color(0xff2D6A4F),
//                               fontSize: height(context) / 48,
//                             )),
//                         SizedBox(height: height(context) * 0.01),
//                         Container(
//                           height: height(context) / 17,
//                           width: width(context),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         SizedBox(height: height(context) * 0.02),
//                         Text("Password",
//                             style: TextStyle(
//                               color: Color(0xff2D6A4F),
//                               fontSize: height(context) / 48,
//                             )),
//                         SizedBox(height: height(context) * 0.01),
//                         Container(
//                           height: height(context) / 17,
//                           width: width(context),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         SizedBox(height: height(context) * 0.01),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text("Forgot Password",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: height(context) / 51,
//                                 )),
//                           ],
//                         ),
//                         SizedBox(height: height(context) * 0.02),
//                         Container(
//                           height: height(context) / 16,
//                           width: width(context),
//                           decoration: BoxDecoration(
//                             color: Color(0xff2D6A4F),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                               child: Text(
//                             "Log in",
//                             style: TextStyle(color: Colors.white),
//                           )),
//                         ),
//                         SizedBox(height: height(context) * 0.01),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Or Create A New Account",
//                                 style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: height(context) / 55,
//                                 )),
//                           ],
//                         ),
//                         SizedBox(height: height(context) * 0.01),
//                         Container(
//                           height: height(context) / 16,
//                           width: width(context),
//                           decoration: BoxDecoration(
//                             color: Color(0xff95D5B2),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                               child: Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 color: Color(0xff2D6A4F),
//                                 fontWeight: FontWeight.bold),
//                           )),
//                         ),
//                         SizedBox(height: height(context) * 0.01),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Login With",
//                                 style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: height(context) / 55,
//                                 )),
//                           ],
//                         ),
//                         SizedBox(height: height(context) * 0.02),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: List.generate(
//                               3,
//                               (index) => Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Container(
//                                         height: height(context) * 0.06,
//                                         width: width(context) * 0.12,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Colors.grey.shade300,
//                                         ),
//                                       )
//                                     ],
//                                   )),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           IconButton(
//             splashRadius: 20,
//             onPressed: () {
//               List x = snap.data!['favourite'];
//               if ((snap.data!['favourite'] as List).contains(data[index].id)) {
//                 x.remove(data[index].id);
//                 FirebaseFirestore.instance
//                     .collection('user')
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .update({'favourite': x});
//               } else {
//                 x.add(data[index].id);
//                 FirebaseFirestore.instance
//                     .collection('user')
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .update({'favourite': x});
//               }
//             },
//             icon: (snap.data!['favourite'] as List).contains(data[index].id)
//                 ? Icon(Icons.favorite, color: red)
//                 : Icon(
//                     Icons.favorite_border,
//                     color: grey,
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
