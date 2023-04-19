import 'dart:io';
import 'package:e_com/globle/shardpefrence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/authantication/google%20auth%20service/google_auth_service.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:e_com/screens/tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../authantication/email authantication/EmailAuthService.dart';
import '../common_screen/Comman_Container.dart';
import '../getx/controller.dart';
import '../globle/profile_controller.dart';
import '../globle/variable.dart';
import 'Favorite_Screen.dart';

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
      backgroundColor: Color(0xfff0f0f0),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return GetBuilder<Controller>(
              builder: (controller) {
                return Column(
                  children: [
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
                              if (index == 3) {
                                Get.to(Favorite_Screen());
                              } else if (index == 5) {
                                EmailAuthService.LogoutUser()
                                    .then((value) async {
                                  SharedPreferences sh =
                                      await SharedPreferences.getInstance();
                                  GoogleAuthService.googleSignOut();
                                  sh
                                      .remove("email")
                                      .then((value) => Get.off(Tab_Bar()));
                                });
                                sharedPreferences!.remove("profile_email");
                                sharedPreferences!.remove("profile_image");
                                sharedPreferences!.remove("profile_image");
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
