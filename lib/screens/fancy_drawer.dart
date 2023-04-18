import 'package:e_com/screens/splash_screen.dart';
import 'package:e_com/screens/tab_bar.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../authantication/email authantication/EmailAuthService.dart';
import '../authantication/google auth service/google_auth_service.dart';
import '../common_screen/Comman_text.dart';
import '../globle/shardpefrence.dart';
import '../globle/variable.dart';

class IFancyDrawer extends StatefulWidget {
  const IFancyDrawer({Key? key}) : super(key: key);

  @override
  _IFancyDrawerState createState() => _IFancyDrawerState();
}

class _IFancyDrawerState extends State<IFancyDrawer>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.transparent,
        controller: _controller,
        drawerItems: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [DarkGreen2, LightGreen]),
                        borderRadius: BorderRadius.circular(15.sp)),
                    accountName: Comman_Text(
                      // text: sharedPreferences!.getString("profile_name")!,
                      text: "profile email",
                      color: white,
                      fontSize: 16.sp,
                    ),
                    accountEmail: Comman_Text(
                      //text: sharedPreferences!.getString("profile_email")!,
                      text: "profile email",
                      color: white,
                      fontSize: 12.sp,
                    ),
                    currentAccountPicture:
                        CircleAvatar(backgroundColor: Colors.white),
                    // currentAccountPicture: InkWell(
                    //   child: Container(
                    //     height: 80.sp,
                    //     width: 80.sp,
                    //     child: CircleAvatar(
                    //       backgroundImage: NetworkImage(
                    //           sharedPreferences!.getString("profile_image")!),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.black,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Comman_Text(
              //         // text: sharedPreferences!.getString("profile_name")!,
              //         text: "profile email",
              //         color: black,
              //         fontSize: 16.sp,
              //       ),
              //       Comman_Text(
              //         //text: sharedPreferences!.getString("profile_email")!,
              //         text: "profile email",
              //         color: black,
              //         fontSize: 12.sp,
              //       ),
              //     ],
              //   ),
              //   height: Get.height * 0.2,
              //   width: Get.width * 0.6,
              // )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                drawer.length,
                (index) => InkWell(
                      onTap: () {
                        if (index == 2) {
                          //Get.to(OderScreen());
                        }
                        if (index == 5) {
                          FirebaseAuth.instance.signOut();
                          EmailAuthService.LogoutUser().then((value) async {
                            SharedPreferences sh =
                                await SharedPreferences.getInstance();
                            sh.setBool(Splash_ScreenState.KeyValue, false);
                            GoogleAuthService.googleSignOut();
                            sh
                                .remove("email")
                                .then((value) => Get.off(Tab_Bar()));
                          });
                          sharedPreferences!.remove("profile_email");
                          sharedPreferences!.remove("profile_image");
                          sharedPreferences!.remove("profile_name");
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.sp),
                        child: Container(
                          height: 45.sp,
                          width: 206.sp,
                          decoration: BoxDecoration(
                              // color: white,
                              gradient: LinearGradient(
                                  colors: [DarkGreen2, LightGreen]),
                              boxShadow: [
                                BoxShadow(
                                    color: grey,
                                    blurRadius: 4,
                                    offset: Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(13)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12.sp,
                              ),
                              drawer[index]['icon'],
                              SizedBox(
                                width: 15.sp,
                              ),
                              Comman_Text(
                                text: drawer[index]['name'],
                                fontSize: 16.sp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.sp),
            child: Row(
              children: [
                Image.asset(
                  "asserts/logo/text_logo.png",
                  width: 150.sp,
                ),
              ],
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            title: const Text(
              "Some appbar",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                _controller.toggle();
              },
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Text("Body"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
