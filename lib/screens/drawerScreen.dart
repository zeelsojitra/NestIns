import 'package:e_com/screens/splash_screen.dart';
import 'package:e_com/screens/tab_bar.dart';
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
import 'login_screen_h.dart';
import 'orderScreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Column(
        children: [
          Stack(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [DarkGreen2, LightGreen]),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(140))),
                  accountName: Padding(
                    padding: EdgeInsets.only(top: 20.sp),
                    child: Comman_Text(
                      text: sharedPreferences!.getString("profile_name")!,
                      color: white,
                      fontSize: 16.sp,
                    ),
                  ),
                  accountEmail: Comman_Text(
                    text: sharedPreferences!.getString("profile_email")!,
                    color: white,
                    fontSize: 12.sp,
                  ),
                  currentAccountPicture: InkWell(
                    child: Container(
                      height: 80.sp,
                      width: 80.sp,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString("profile_image")!),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 225,
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: white,
                  child: Icon(Icons.edit_outlined, color: green),
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(
                7,
                (index) => InkWell(
                      onTap: () {
                        if (index == 2) {
                          Get.to(OderScreen());
                        }
                        if (index == 6) {
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.sp, vertical: 7.sp),
                        child: Container(
                          height: 45.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: white,
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
                                //fontFamily: "JV1",
                                color: DarkGreen2,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
