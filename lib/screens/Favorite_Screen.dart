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
      appBar: coomanAppBar(
        //centerTitle: true,
        action: [],
        name: "Favourite",
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
          return StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Product').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return snapshot.data!.docs.isNotEmpty
                    ? Expanded(
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
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Stack(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Comman_Container(
                                                height: Get.height * 0.18,
                                                width: Get.width * 0.40,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      '${data[index]['image']}',
                                                    ),
                                                    fit: BoxFit.cover),
                                              ),
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
                                                    fontFamily: "JB1",
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
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 5,
                                        // child: Container(
                                        //   height: 27.sp,
                                        //   width: 27.sp,
                                        //   decoration: BoxDecoration(
                                        //     color: white,
                                        //     shape: BoxShape.circle,
                                        //   ),
                                        child: IconButton(
                                          splashRadius: 20,
                                          onPressed: () {
                                            List x = snap.data!['favourite'];
                                            if ((snap.data!['favourite']
                                                    as List)
                                                .contains(data[index].id)) {
                                              x.remove(data[index].id);
                                              FirebaseFirestore.instance
                                                  .collection('user')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({'favourite': x});
                                            } else {
                                              x.add(data[index].id);
                                              FirebaseFirestore.instance
                                                  .collection('user')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({'favourite': x});
                                            }
                                          },
                                          icon: (snap.data!['favourite']
                                                          as List)
                                                      .contains(
                                                          data[index].id) ==
                                                  true
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: (snap.data![
                                                                  'favourite']
                                                              as List)
                                                          .contains(
                                                              data[index].id)
                                                      ? red
                                                      : grey,
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  color: (snap.data![
                                                                  'favourite']
                                                              as List)
                                                          .contains(
                                                              data[index].id)
                                                      ? red
                                                      : grey,
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      )
                    : Image(image: AssetImage("asserts/image/wishlist.png"));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
