// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/view/bottom_Navigation/bottom_navi_demo.dart';
import 'package:e_com/src/view/searchdemo.dart';
import 'package:e_com/src/constant/shardpefrence.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/provider/getx/controller.dart';
import 'package:e_com/src/view/authantication/email_authantication/email_auth_service.dart';
import 'package:e_com/src/view/authantication/google_auth_service/google_auth_service.dart';
import 'package:e_com/src/view/category/categories_screens.dart';
import 'package:e_com/src/view/favorite_screen.dart';
import 'package:e_com/src/view/splash_screen.dart';
import 'package:e_com/src/view/tab_bar.dart';
import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'details_screen.dart';
import 'order_screen.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController _controller;
  String? useremail, username;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> getUserEmail() async {
    final SharedPreferences prefs = await _prefs;

    final email = prefs.getString("profile_email");
    final name = prefs.getString("profile_name");

    useremail = email;
    username = name;
    setState(() {});
  }

  @override
  void initState() {
    getUserEmail();
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
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [darkGreen2, lightGreen]),
                        borderRadius: BorderRadius.circular(17)),
                    accountName: CommanText(
                      text: sharedPreferences!.getString("profile_name")!,
                      //fontFamily: "JV1",
                      color: white,
                      fontSize: 16.sp,
                    ),
                    accountEmail: CommanText(
                      text: sharedPreferences!.getString("profile_email") ?? "",
                      //fontFamily: "JV1",
                      color: white,
                      fontSize: 16.sp,
                    ),

                    //margin: EdgeInsets.symmetric(horizontal: 10),
                    currentAccountPicture: Center(
                      child: Container(
                        height: 50.sp,
                        width: 50.sp,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: CommanText(
                              color: darkGreen2,
                              //fontFamily: "JV1",
                              fontWeight: FontWeight.bold,
                              fontSize: Get.height * 0.03,
                              text:
                                  "${sharedPreferences!.getString("profile_name")}"
                                      .capitalized
                                      .split("")
                                      .first),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.black,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       CommanText(
              //         // text: sharedPreferences!.getString("profile_name")!,
              //         text: "profile email",
              //         color: black,
              //         fontSize: 16.sp,
              //       ),
              //       CommanText(
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
                    Get.to(const BottomNavigation());
                  }
                  if (index == 1) {
                    Get.to(const CategoriesScreen());
                  }
                  if (index == 2) {
                    Get.to(const OderScreen());
                  }
                  if (index == 3) {
                    Get.to(const FavoriteScreen());
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
                            title: const Text("Logout",
                                style: TextStyle(
                                    fontFamily: "JV1",
                                    fontWeight: FontWeight.bold)),
                            content: const Text(
                                "Are you sure you want to logout?",
                                style: TextStyle(fontFamily: "JV1")),
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
                                  EmailAuthService.loginUser()
                                      .then((value) async {
                                    SharedPreferences sh =
                                        await SharedPreferences.getInstance();
                                    sh.setBool(
                                        SplashScreenState.keyValue, false);
                                    GoogleAuthService.googleSignOut();
                                    sh.remove("email").then((value) =>
                                        Get.off(const TabBarScreen()));
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
                        gradient: const LinearGradient(
                            colors: [darkGreen2, lightGreen]),
                        boxShadow: const [
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
                        CommanText(
                          text: drawer[index]['name'],
                          //fontFamily: "JV1",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
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
          appBar: AppBar(
            elevation: 4.0,
            title: const Text(
              "Home",
              style: TextStyle(fontFamily: "JV1", color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(const SearchPage());
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
            ],
            backgroundColor: darkGreen2,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                _controller.toggle();
              },
            ),
          ),
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              onBackButtonPressed;
            },
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
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
                                          controller.pageview(index);
                                        },
                                        aspectRatio: 16 / 9,
                                        height: 130.sp,
                                        autoPlayAnimationDuration:
                                            const Duration(seconds: 2),
                                        enlargeCenterPage: true,
                                        itemCount: pageview.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CommanContainer(
                                              // child: Padding(
                                              //   padding: EdgeInsets.symmetric(
                                              //       vertical: 15.sp,
                                              //       horizontal: 15.sp),
                                              //   child: Column(
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     children: [
                                              //       CommanText(
                                              //         text: Pageview[index]
                                              //             ['title'],
                                              //         color: white,
                                              //         fontWeight: FontWeight.w400,
                                              //         fontSize: 20.sp,
                                              //       ),
                                              //       SizedBox(
                                              //         height: 5.sp,
                                              //       ),
                                              //       CommanText(
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
                                                  pageview[index],
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
                                              CommanText(
                                                text: "Catalogue",
                                                fontSize: 17.sp,
                                                //fontFamily: "JV1",
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const Spacer(),
                                              TextButton(
                                                onPressed: () {
                                                  Get.to(
                                                      const CategoriesScreen());
                                                },
                                                child: CommanText(
                                                  text: "See All  >",
                                                  //fontFamily: "JV1",
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
                                            physics:
                                                const BouncingScrollPhysics(),
                                            padding:
                                                EdgeInsets.only(right: 20.sp),
                                            itemCount: catalogue.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 15.sp),
                                                width: 70.sp,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        black54,
                                                        BlendMode.darken,
                                                      ),
                                                      image: AssetImage(
                                                          catalogue[index]
                                                              ['img']),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                  child: CommanText(
                                                    text: catalogue[index]
                                                        ['name'],
                                                    color: white,
                                                    //fontFamily: "JV1",
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
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
                                          child: CommanText(
                                            text: "Products",
                                            fontSize: 18.sp,
                                            //fontFamily: "JV1",
                                            fontWeight: FontWeight.w700,
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('Product')
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            QuerySnapshot<
                                                                Map<String,
                                                                    dynamic>>>
                                                        snapshot) {
                                                  if (snapshot.connectionState ==
                                                          ConnectionState
                                                              .done ||
                                                      snapshot.hasData) {
                                                    var data =
                                                        snapshot.data!.docs;
                                                    return snapshot.data!.docs
                                                            .isNotEmpty
                                                        ? GridView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                mainAxisSpacing:
                                                                    1,
                                                                crossAxisSpacing:
                                                                    1,
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisExtent:
                                                                    300),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final product =
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index];
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
                                                                                BorderRadius.circular(20),
                                                                          ),
                                                                          elevation:
                                                                              10,
                                                                          color:
                                                                              grey,
                                                                          child:
                                                                              CommanContainer(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            ontap:
                                                                                () {
                                                                              Get.to(
                                                                                DetilsScreen(
                                                                                  sid: product['seller_id'],
                                                                                  pid: product['product_id'],
                                                                                  buynow: snap.data!['buyNow'],
                                                                                  image: product['image'],
                                                                                  category: product["product_catagory"],
                                                                                  details: product["product_details"],
                                                                                  name: product["product_name"],
                                                                                  price: product["product_price"],
                                                                                  stock: product['product_stock'],
                                                                                ),
                                                                              );
                                                                            },
                                                                            height:
                                                                                155.sp,
                                                                            width:
                                                                                double.infinity,
                                                                            color:
                                                                                white,
                                                                            image:
                                                                                DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage(product['image'].toString()),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          bottom:
                                                                              -15,
                                                                          right:
                                                                              -10,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                30.sp,
                                                                            width:
                                                                                30.sp,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(color: Colors.grey.shade200, spreadRadius: 2, blurRadius: 1)
                                                                              ],
                                                                              color: white,
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: IconButton(
                                                                                splashRadius: 20,
                                                                                onPressed: () {
                                                                                  List x = snap.data!['favourite'];
                                                                                  if ((snap.data!['favourite'] as List).contains(data[index].id)) {
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
                                                                                icon: (snap.data!['favourite'] as List).contains(data[index].id)
                                                                                    ? const Icon(Icons.favorite, color: red)
                                                                                    : const Icon(
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
                                                                      height:
                                                                          8.sp,
                                                                    ),
                                                                    CommanText(
                                                                      text: product[
                                                                          "product_name"],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      //fontFamily:
                                                                      //"JV1",
                                                                      fontSize:
                                                                          15.sp,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          2.sp,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        CommanText(
                                                                          text:
                                                                              "₹",
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              black54,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              2.sp,
                                                                        ),
                                                                        CommanText(
                                                                          text:
                                                                              product['product_price'],
                                                                          fontSize:
                                                                              17.sp,
                                                                          color:
                                                                              red,
                                                                          //fontFamily:
                                                                          //"JV1",
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : Column(
                                                            children: [
                                                              Image.asset(
                                                                emptyOrder,
                                                                height:
                                                                    Get.height *
                                                                        0.35,
                                                                width:
                                                                    Get.width,
                                                              ),
                                                            ],
                                                          );
                                                  } else {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        )
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
      ),
    );
  }

  Future<bool> onBackButtonPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CommanText(text: "Really?"),
        content: const CommanText(text: "Do you want to close app??"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              icon: const Icon(
                Icons.done,
                color: green,
              )),
        ],
      ),
    );
  }
}
