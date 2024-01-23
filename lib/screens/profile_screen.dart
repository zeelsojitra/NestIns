import 'dart:developer';
import 'dart:io';
import 'package:e_com/authantication/email_authantication/email_auth_service.dart';
import 'package:e_com/globle/shardpefrence.dart';
import 'package:e_com/authantication/google_auth_service/google_auth_service.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:e_com/screens/Roadmap/roadmap_screen.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:e_com/screens/tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../common_screen/comman_container.dart';
import '../getx/controller.dart';
import '../globle/profile_controller.dart';
import '../globle/variable.dart';
import 'favorite_screen.dart';
import 'order_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  ImagePicker picker = ImagePicker();

  Profileimg pi = Get.put(Profileimg());

  pickImage(ImageSource imageSource) async {
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
      log("Firebase Storage ==>>${e.message}");
    }
    return null;
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: CommanContainer(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                darkGreen2,
                                lightGreen,
                              ],
                            ),
                            width: Get.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 23.sp,
                                    backgroundColor: white,
                                    child: CommanText(
                                        //fontFamily: "JM1",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: darkGreen2,
                                        text: sharedPreferences!
                                            .getString("profile_name")!
                                            .capitalized
                                            .split("")
                                            .first),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  CommanText(
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
                                  CommanText(
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // CommanContainer(
                      //   height: 75.sp,
                      //   width: double.infinity,
                      //   borderRadius:
                      //       BorderRadius.only(bottomRight: Radius.circular(140)),
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       darkGreen2,
                      //       lightGreen,
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
                      //             CommanText(
                      //               text: "profile name",
                      //               color: white,
                      //               fontSize: 18.sp,
                      //             ),
                      //             SizedBox(
                      //               height: 3.sp,
                      //             ),
                      //             CommanText(
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
                                  Get.to(const RoadMapScreen());
                                } else if (index == 2) {
                                  Get.to(const OderScreen());
                                } else if (index == 3) {
                                  Get.to(const FavoriteScreen());
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
                                                EmailAuthService.logoutUser()
                                                    .then((value) async {
                                                  SharedPreferences sh =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  sh.setBool(
                                                      SplashScreenState
                                                          .keyValue,
                                                      false);
                                                  GoogleAuthService
                                                      .googleSignOut();
                                                  sh.remove("email").then(
                                                      (value) => Get.off(
                                                          const TabBarScreen()));
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
                              child: CommanContainer(
                                height: 50.sp,
                                width: double.infinity,
                                color: white,
                                boxShadow: const [
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
                                    CommanText(
                                      text: profile[index]['name'],
                                      //fontFamily: "JV1",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: darkGreen2,
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
