import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/media_query.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class OderDetails extends StatefulWidget {
  final String image, name, price, category, details, date;
  const OderDetails({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.details,
    required this.date,
  });

  @override
  State<OderDetails> createState() => OderDetailsState();
}

class OderDetailsState extends State<OderDetails> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        title: const CommanText(
          text: "Order Details",
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          SizedBox(
            width: 20.sp,
          ),
          // Obx(
          //   () => InkWell(
          //     onTap: () {},
          //     child: contoller.like_btn_details_screen.value == true
          //         ? IconButton(
          //             onPressed: () {
          //               if (contoller.like_btn_details_screen.value == true) {
          //                 contoller.like_btn_details_screen.value = false;
          //               } else {
          //                 contoller.like_btn_details_screen.value = true;
          //               }
          //             },
          //             icon: Icon(
          //               Icons.favorite,
          //               color: Colors.red,
          //             ))
          //         : IconButton(
          //             onPressed: () {
          //               if (contoller.like_btn_details_screen.value == true) {
          //                 contoller.like_btn_details_screen.value = false;
          //               } else {
          //                 contoller.like_btn_details_screen.value = true;
          //               }
          //             },
          //             icon: Icon(
          //               Icons.favoriteOutline,
          //               color: Colors.white,
          //             ),
          //           ),
          //   ),
          // ),
          SizedBox(
            width: 20.sp,
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Product')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("Hello");
                  }
                  return snapshot.data!.docs.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          widget.image,
                                          // height: height(context) / 3,
                                          // width: width(context) / 2,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommanText(
                                          text: widget.name,
                                          color: black,
                                          //fontFamily: "JV1",
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        CommanText(
                                          text: "₨ :- ${widget.price}",
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        CommanText(
                                          text: widget.category,
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        CommanText(
                                          text: widget.details,
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        CommanText(
                                          text: widget.date,
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Text("Hello");
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
