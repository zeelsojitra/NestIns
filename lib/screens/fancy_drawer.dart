import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/bottom_Navigation/bottom_navi_demo.dart';
import 'package:e_com/getx/controller.dart';
import 'package:e_com/screens/Favorite_Screen.dart';
import 'package:e_com/screens/splash_screen.dart';
import 'package:e_com/screens/tab_bar.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../authantication/email authantication/EmailAuthService.dart';
import '../authantication/google auth service/google_auth_service.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../globle/shardpefrence.dart';
import '../globle/variable.dart';
import 'Details_screen.dart';
import 'categories_screen.dart';
import 'login_screen_h.dart';
import 'orderScreen.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1>
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
                width: Get.width * 0.6,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [DarkGreen2, LightGreen]),
                        borderRadius: BorderRadius.circular(17)),
                    accountName: Comman_Text(
                      text: sharedPreferences!.getString("profile_name")!,
                      //text: "profile email",
                      color: white,
                      fontSize: 16.sp,
                    ),
                    accountEmail: Comman_Text(
                      text: sharedPreferences!.getString("profile_email")!,
                      //text: "profile email",
                      color: white,
                      fontSize: 12.sp,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: white,
                      child: Comman_Text(
                          fontFamily: "JM1",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: DarkGreen2,
                          text:
                              "${sharedPreferences!.getString("profile_email")!}"
                                  .split("")
                                  .first),
                    ),
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
                  if (index == 0) {
                    Get.to(Bottom_navigation());
                  }
                  if (index == 1) {
                    Get.to(CategoryScreen_2());
                  }
                  if (index == 2) {
                    Get.to(OderScreen());
                  }
                  if (index == 3) {
                    Get.to(Favorite_Screen());
                  }
                  if (index == 4) {
                    Share.share("NestIn");
                  }
                  if (index == 5) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
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
                                        await SharedPreferences.getInstance();
                                    sh.setBool(
                                        Splash_ScreenState.KeyValue, false);
                                    GoogleAuthService.googleSignOut();
                                    sh
                                        .remove("email")
                                        .then((value) => Get.off(Tab_Bar()));
                                  });
                                  sharedPreferences!.remove("profile_email");
                                  sharedPreferences!.remove("profile_image");
                                  sharedPreferences!.remove("profile_name");
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 15.sp),
                  child: Container(
                    height: Get.height * 0.062,
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                        // color: white,
                        gradient:
                            LinearGradient(colors: [DarkGreen2, LightGreen]),
                        boxShadow: [
                          BoxShadow(
                              color: grey, blurRadius: 4, offset: Offset(2, 2))
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
              ),
            ),
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
          backgroundColor: white,
          appBar: AppBar(
            elevation: 4.0,
            title: const Text(
              "Home",
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_shopping_cart_outlined),
              )
            ],
            backgroundColor: DarkGreen2,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                _controller.toggle();
              },
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<Controller>(
                          builder: (controller) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    VxSwiper.builder(
                                      onPageChanged: (index) {
                                        controller.Pageview(index);
                                      },
                                      aspectRatio: 16 / 9,
                                      height: 130.sp,
                                      autoPlayAnimationDuration:
                                          Duration(seconds: 2),
                                      enlargeCenterPage: true,
                                      itemCount: Pageview.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Comman_Container(
                                            // child: Padding(
                                            //   padding: EdgeInsets.symmetric(
                                            //       vertical: 15.sp,
                                            //       horizontal: 15.sp),
                                            //   child: Column(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //     children: [
                                            //       Comman_Text(
                                            //         text: Pageview[index]
                                            //             ['title'],
                                            //         color: white,
                                            //         fontWeight: FontWeight.w400,
                                            //         fontSize: 20.sp,
                                            //       ),
                                            //       SizedBox(
                                            //         height: 5.sp,
                                            //       ),
                                            //       Comman_Text(
                                            //         text: Pageview[index]
                                            //             ['subtitile'],
                                            //         color: white,
                                            //         fontWeight: FontWeight.w400,
                                            //         fontSize: 18.sp,
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                            width: double.infinity,
                                            color: red,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                Pageview[index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // Positioned(
                                    //   bottom: 15,
                                    //   right: 0,
                                    //   left: 0,
                                    //   child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: List.generate(
                                    //         Pageview.length,
                                    //         (index) => Padding(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 1.sp),
                                    //           child: CircleAvatar(
                                    //             radius: 5,
                                    //             backgroundColor:
                                    //                 controller.onchange == index
                                    //                     ? green
                                    //                     : white,
                                    //           ),
                                    //         ),
                                    //       )),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp),
                                        child: Row(
                                          children: [
                                            Comman_Text(
                                              text: "Catalogue",
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                Get.to(CategoryScreen_2());
                                              },
                                              child: Comman_Text(
                                                text: "See All  >",
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      SizedBox(
                                        height: 73.sp,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          padding:
                                              EdgeInsets.only(right: 20.sp),
                                          itemCount: Catalogue.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(left: 15.sp),
                                              width: 70.sp,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      black54,
                                                      BlendMode.darken,
                                                    ),
                                                    image: AssetImage(
                                                        Catalogue[index]
                                                            ['img']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Center(
                                                child: Comman_Text(
                                                  text: Catalogue[index]
                                                      ['name'],
                                                  color: white,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.sp,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp),
                                        child: Comman_Text(
                                          text: "Products",
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    DocumentSnapshot<
                                                        Map<String, dynamic>>>
                                                snap) {
                                          if (snap.hasData) {
                                            return StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Product')
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          QuerySnapshot<
                                                              Map<String,
                                                                  dynamic>>>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  var data =
                                                      snapshot.data!.docs;
                                                  return GridView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .data!.docs.length,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            mainAxisSpacing: 1,
                                                            crossAxisSpacing: 1,
                                                            crossAxisCount: 2,
                                                            mainAxisExtent:
                                                                300),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final product = snapshot
                                                          .data!.docs[index];
                                                      return Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.sp),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Card(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  elevation: 10,
                                                                  color: grey,
                                                                  child:
                                                                      Comman_Container(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    ontap: () {
                                                                      Get.to(
                                                                        DetilsScreen(
                                                                          sid: product[
                                                                              'seller_id'],
                                                                          pid: product[
                                                                              'product_id'],
                                                                          buynow:
                                                                              snap.data!['buyNow'],
                                                                          image:
                                                                              product['image'],
                                                                          category:
                                                                              product["product_catagory"],
                                                                          details:
                                                                              product["product_details"],
                                                                          name:
                                                                              product["product_name"],
                                                                          price:
                                                                              product["product_price"],
                                                                          stock:
                                                                              product['product_stock'],
                                                                        ),
                                                                      );
                                                                    },
                                                                    height:
                                                                        155.sp,
                                                                    width: double
                                                                        .infinity,
                                                                    color:
                                                                        white,
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          product!['image']
                                                                              .toString()),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: -18,
                                                                  right: -15,
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        27.sp,
                                                                    width:
                                                                        27.sp,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors
                                                                                .grey.shade200,
                                                                            spreadRadius:
                                                                                2,
                                                                            blurRadius:
                                                                                1)
                                                                      ],
                                                                      color:
                                                                          white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          IconButton(
                                                                        splashRadius:
                                                                            20,
                                                                        onPressed:
                                                                            () {
                                                                          List
                                                                              x =
                                                                              snap.data!['favourite'];
                                                                          if ((snap.data!['favourite'] as List)
                                                                              .contains(data[index].id)) {
                                                                            x.remove(data[index].id);
                                                                            FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                                                              'favourite': x
                                                                            });
                                                                          } else {
                                                                            x.add(data[index].id);
                                                                            FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                                                              {
                                                                                'favourite': x
                                                                              },
                                                                            );
                                                                          }
                                                                        },
                                                                        icon: (snap.data!['favourite'] as List).contains(data[index]
                                                                                .id)
                                                                            ? Icon(Icons.favorite,
                                                                                color: red)
                                                                            : Icon(
                                                                                Icons.favorite_border,
                                                                                color: grey,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8.sp,
                                                            ),
                                                            Comman_Text(
                                                              text: product[
                                                                  "product_name"],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15.sp,
                                                            ),
                                                            SizedBox(
                                                              height: 6.sp,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Comman_Text(
                                                                  text: "₹",
                                                                  fontSize:
                                                                      14.sp,
                                                                  color:
                                                                      black54,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.sp,
                                                                ),
                                                                Comman_Text(
                                                                  text: product[
                                                                      'product_price'],
                                                                  fontSize:
                                                                      17.sp,
                                                                  color:
                                                                      DarkGreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              },
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
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
}
