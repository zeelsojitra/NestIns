import 'dart:io';
import 'package:e_com/globle/shardpefrence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/authantication/google%20auth%20service/google_auth_service.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:e_com/screens/RoadMap/RoadMap_Screen.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:e_com/screens/tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../authantication/email authantication/EmailAuthService.dart';
import '../common_screen/Comman_Container.dart';
import '../getx/controller.dart';
import '../globle/profile_controller.dart';
import '../globle/variable.dart';
import 'Favorite_Screen.dart';
import 'login_screen_h.dart';
import 'orderScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  ImagePicker picker = ImagePicker();

  Profileimg pi = Get.put(Profileimg());

  PickImage(ImageSource imageSource) async {
    final file = await picker.pickImage(source: imageSource);

    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Future<String?> uplodeImage() async {
    try {
      await FirebaseStorage.instance.ref('profileImge').putFile(image!);
      final url =
          await FirebaseStorage.instance.ref('profileImge').getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print("Firebase Storage ==>>${e.message}");
    }
  }

  // profiledata() async {
  //   SharedPreferences getprofiledata = await SharedPreferences.getInstance();
  //   await getprofiledata.getString("profile_image");
  //   getprofiledata.getString("profile_name");
  //   getprofiledata.getString("profile_email");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        //centerTitle: true,
        action: [],
        name: "Profile",
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return GetBuilder<Controller>(
              builder: (controller) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: Comman_Container(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                DarkGreen2,
                                LightGreen,
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 23.sp,
                                    backgroundColor: white,
                                    child: Comman_Text(
                                        //fontFamily: "JM1",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: DarkGreen2,
                                        text:
                                            "${sharedPreferences!.getString("profile_name")!}"
                                                .capitalized
                                                .split("")
                                                .first),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Comman_Text(
                                    //fontFamily: "JM1",

                                    text: sharedPreferences!
                                        .getString("profile_name")!,
                                    //text: "profile email",
                                    color: white,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0001,
                                  ),
                                  Comman_Text(
                                    //fontFamily: "JM1",
                                    text: sharedPreferences!
                                        .getString("profile_email")!,
                                    //text: "profile email",
                                    color: white,
                                    fontSize: 11.sp,
                                  ),
                                ],
                              ),
                            ),
                            height: Get.height * 0.17,
                            width: Get.width,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // Comman_Container(
                      //   height: 75.sp,
                      //   width: double.infinity,
                      //   borderRadius:
                      //       BorderRadius.only(bottomRight: Radius.circular(140)),
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       DarkGreen2,
                      //       LightGreen,
                      //     ],
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 10.sp),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 10.sp,
                      //         ),
                      //         Stack(
                      //           clipBehavior: Clip.none,
                      //           children: [
                      //             Container(
                      //               height: 80,
                      //               width: 80,
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //               ),
                      //               child: ClipOval(
                      //                 child: controller.image == null
                      //                     ? Icon(Icons.camera)
                      //                     : Image.file(
                      //                         controller.image!,
                      //                         fit: BoxFit.cover,
                      //                       ),
                      //               ),
                      //             ),
                      //             Positioned(
                      //               bottom: 0,
                      //               right: 0,
                      //               child: InkWell(
                      //                 onTap: () {
                      //                   controller.PickImage(ImageSource.gallery);
                      //                 },
                      //                 child: CircleAvatar(
                      //                   radius: 13,
                      //                   backgroundColor: black87,
                      //                   child: Icon(
                      //                     size: 18,
                      //                     color: green,
                      //                     Icons.camera_alt,
                      //                   ),
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //         SizedBox(
                      //           width: 10.sp,
                      //         ),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Comman_Text(
                      //               text: "profile name",
                      //               color: white,
                      //               fontSize: 18.sp,
                      //             ),
                      //             SizedBox(
                      //               height: 3.sp,
                      //             ),
                      //             Comman_Text(
                      //               text: "profile email",
                      //               color: white,
                      //               fontSize: 12.sp,
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10.sp,
                      // ),
                      Column(
                        children: List.generate(
                          6,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.sp, vertical: 8.sp),
                            child: GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                  Get.to(RoadMapScreen());
                                } else if (index == 2) {
                                  Get.to(OderScreen());
                                } else if (index == 3) {
                                  Get.to(Favorite_Screen());
                                } else if (index == 5) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Logout",
                                              style:
                                                  TextStyle(fontFamily: "JM1")),
                                          content: const Text(
                                              "Are you sure you want to logout?",
                                              style:
                                                  TextStyle(fontFamily: "JV1")),
                                          actions: [
                                            IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.done,
                                                color: Colors.green,
                                              ),
                                              onPressed: () async {
                                                FirebaseAuth.instance.signOut();
                                                EmailAuthService.LogoutUser()
                                                    .then((value) async {
                                                  SharedPreferences sh =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  sh.setBool(
                                                      Splash_ScreenState
                                                          .KeyValue,
                                                      false);
                                                  GoogleAuthService
                                                      .googleSignOut();
                                                  sh.remove("email").then(
                                                      (value) =>
                                                          Get.off(Tab_Bar()));
                                                });
                                                sharedPreferences!
                                                    .remove("profile_email");
                                                sharedPreferences!
                                                    .remove("profile_image");
                                                sharedPreferences!
                                                    .remove("profile_name");
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              child: Comman_Container(
                                height: 50.sp,
                                width: double.infinity,
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: grey,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(13),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15.sp,
                                    ),
                                    Icon(
                                      profile[index]['Icon'],
                                      color: iconColor,
                                    ),
                                    SizedBox(
                                      width: 15.sp,
                                    ),
                                    Comman_Text(
                                      text: profile[index]['name'],
                                      //fontFamily: "JV1",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: DarkGreen2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
