import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/loding.dart';
import '../globle/variable.dart';
import 'OderDetails.dart';

class OderScreen extends StatefulWidget {
  const OderScreen({Key? key}) : super(key: key);

  @override
  State<OderScreen> createState() => _OderScreenState();
}

class _OderScreenState extends State<OderScreen> {
  final globalkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        name: "Your Order",
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Order")
            .orderBy("createdDate", descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
            List<DocumentSnapshot> order = snapshot.data!.docs;
            print("${order.length}");
            print("${FirebaseAuth.instance.currentUser!.uid}");
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Image.asset(
                      Empty_order,
                      height: Get.height * 0.35,
                      width: Get.width,
                    ),
                  )
                : SizedBox(
                    height: 597.sp,
                    child: ListView.separated(
                      itemCount: order.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Comman_Container(
                              ontap: () {
                                // Get.to(OderDetails(
                                //   date: order[index].get("createdDate"),
                                //   image: order[index].get("image"),
                                //   name: order[index].get("product_name"),
                                //   price: order[index].get("product_price"),
                                //   details: order[index].get("product_details"),
                                //   category:
                                //       order[index].get("product_catagory"),
                                // ));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                                child: Comman_Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.sp),
                                  height: 120.sp,
                                  width: 120.sp,
                                  color: grey,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          order[index].get("image"))),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 20,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Comman_Text(
                                    text: "${order[index].get("product_name")}",
                                    fontSize: 15.sp,
                                    //fontFamily: "JM1",
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  Comman_Text(
                                    text: order[index].get("product_catagory"),
                                    fontSize: 15.sp,
                                    // fontFamily: "JV1",
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Comman_Text(
                                    text:
                                        order[index].get("product_price") + "₹",
                                    fontSize: 15.sp,
                                    color: red,
                                    //fontFamily: "JV1"
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MaterialButton(
                                          child: Comman_Text(
                                            text: "Cancel Order",
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Cancel Order",
                                                        style: TextStyle(
                                                            fontFamily: "JV1",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    content: const Text(
                                                        "Are you sure you want to Cancel Order?",
                                                        style: TextStyle(
                                                            fontFamily: "JV1")),
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
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Order")
                                                              .doc(order[index]
                                                                  .id)
                                                              .delete();
                                                          Get.back();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          color: red,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 2.sp,
                          color: black,
                          thickness: 1,
                        );
                      },
                    ),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
