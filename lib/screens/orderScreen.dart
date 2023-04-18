import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_Container.dart';
import '../globle/media_query.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height(context) * 0.11,
              width: width(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  gradient: LinearGradient(colors: [
                    Color(0xff2D6A4F),
                    Color(0xff95D5B2),
                  ])),
              child: Padding(
                padding: EdgeInsets.only(top: 17.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: white,
                          size: 30,
                        )),
                    Spacer(),
                    Text(
                      "Oder Screen",
                      style: TextStyle(
                          color: white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
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
                  return SizedBox(
                    height: 565.sp,
                    child: ListView.separated(
                      itemCount: order.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Comman_Container(
                              ontap: () {
                                Get.to(OderDetails(
                                  date: order[index].get("createdDate"),
                                  image: order[index].get("image"),
                                  name: order[index].get("product_name"),
                                  price: order[index].get("product_price"),
                                  details: order[index].get("product_details"),
                                  category:
                                      order[index].get("product_catagory"),
                                ));
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
                                      text:
                                          "Product Name :- ${order[index].get("product_name")}",
                                      fontSize: 15.sp),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Comman_Text(
                                      text:
                                          order[index].get("product_catagory"),
                                      fontSize: 15.sp),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Comman_Text(
                                    text: "OrderId",
                                    fontSize: 15.sp,
                                  ),
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
            )
          ],
        ),
      ),
    );
  }
}
