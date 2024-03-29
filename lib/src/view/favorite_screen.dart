import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
          if (snap.hasData) {
            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Product').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData) {
                  if (snapshot.data?.docs.isNotEmpty ?? false) {
                    log("Rigjt");
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: CommanContainer(
                                              height: Get.height * 0.18,
                                              width: Get.width * 0.40,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${data[index]['image']}',
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
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
                                              CommanText(
                                                text:
                                                    '${data[index]['product_name']}',
                                                fontSize: 15.sp,
                                                ////fontFamily: "JV1",
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              CommanText(
                                                text:
                                                    '${data[index]['product_catagory']}',
                                                fontSize: 15.sp,
                                                //fontFamily: "JV1",
                                                color: grey,
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              CommanText(
                                                text:
                                                    '₹ ${data[index]['product_price']}',
                                                fontSize: 15.sp,
                                                //fontFamily: "JV1",
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
                                    child: IconButton(
                                      splashRadius: 20,
                                      onPressed: () {
                                        List x = snap.data!['favourite'];
                                        if ((snap.data!['favourite'] as List)
                                            .contains(data[index].id)) {
                                          x.remove(data[index].id);
                                          FirebaseFirestore.instance
                                              .collection('user')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .update({'favourite': x});
                                        } else {
                                          x.add(data[index].id);
                                          FirebaseFirestore.instance
                                              .collection('user')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .update({'favourite': x});
                                        }
                                      },
                                      icon: (snap.data!['favourite'] as List)
                                                  .contains(data[index].id) ==
                                              true
                                          ? Icon(
                                              Icons.favorite,
                                              color: (snap.data!['favourite']
                                                          as List)
                                                      .contains(data[index].id)
                                                  ? red
                                                  : grey,
                                            )
                                          : Icon(
                                              Icons.favorite,
                                              color: (snap.data!['favourite']
                                                          as List)
                                                      .contains(data[index].id)
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
                          return SizedBox.fromSize();
                        }
                      },
                    );
                  } else {
                    log("Rong");
                    return const Text("No data Found!");
                  }
                } else {
                  log("Rongg");
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
