import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_Container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';

class Favorite_Screen extends StatefulWidget {
  const Favorite_Screen({Key? key}) : super(key: key);

  @override
  State<Favorite_Screen> createState() => _Favorite_ScreenState();
}

class _Favorite_ScreenState extends State<Favorite_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Comman_Container(
              height: 60.sp,
              width: double.infinity,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              gradient: LinearGradient(
                colors: [
                  DarkGreen2,
                  LightGreen,
                ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: white,
                            size: 30,
                          ),
                        )),
                    Spacer(),
                    Comman_Text(
                      text: "Favourite",
                      color: white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    SizedBox(
                      width: 30.sp,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Comman_Text(
                        text: "5 Items",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      Comman_Text(
                        text: "Sort By : ",
                      ),
                      Comman_Text(
                        text: "Price : ",
                        fontWeight: FontWeight.w500,
                      ),
                      Comman_Text(
                        text: "Lowest to high ",
                        fontWeight: FontWeight.w500,
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
                if (snap.hasData) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Product')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.sp, horizontal: 10.sp),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs;
                              if ((snap.data!['favourite'] as List)
                                  .contains(data[index].id)) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Comman_Container(
                                              height: 200.sp,
                                              width: 150.sp,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  '${data[index]['image']}',
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -10,
                                              right: -17,
                                              child: Container(
                                                height: 27.sp,
                                                width: 27.sp,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  splashRadius: 20,
                                                  onPressed: () {
                                                    List x =
                                                        snap.data!['favourite'];
                                                    if ((snap.data!['favourite']
                                                            as List)
                                                        .contains(
                                                            data[index].id)) {
                                                      x.remove(data[index].id);
                                                      FirebaseFirestore.instance
                                                          .collection('user')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .update(
                                                              {'favourite': x});
                                                    } else {
                                                      x.add(data[index].id);
                                                      FirebaseFirestore.instance
                                                          .collection('user')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .update(
                                                              {'favourite': x});
                                                    }
                                                  },
                                                  icon: (snap.data!['favourite']
                                                                  as List)
                                                              .contains(
                                                                  data[index]
                                                                      .id) ==
                                                          true
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: (snap.data![
                                                                          'favourite']
                                                                      as List)
                                                                  .contains(
                                                                      data[index]
                                                                          .id)
                                                              ? red
                                                              : grey,
                                                        )
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: (snap.data![
                                                                          'favourite']
                                                                      as List)
                                                                  .contains(
                                                                      data[index]
                                                                          .id)
                                                              ? red
                                                              : grey,
                                                        ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.sp,
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Comman_Text(
                                                text:
                                                    '${data[index]['product_name']}',
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              Comman_Text(
                                                text:
                                                    '${data[index]['product_details']}',
                                                fontSize: 11.sp,
                                                color: grey,
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              Comman_Text(
                                                text:
                                                    '${data[index]['product_catagory']}',
                                                fontSize: 15.sp,
                                                color: grey,
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              Comman_Text(
                                                text:
                                                    '₹ ${data[index]['product_price']}',
                                                fontSize: 15.sp,
                                                color: red,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
