import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_Container.dart';
import 'package:e_com/globle/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';
import 'addressscreen.dart';

class DetilsScreen extends StatefulWidget {
  final String image, name, price, category, details, stock, pid, sid;
  final List buynow;

  const DetilsScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.details,
    required this.stock,
    required this.buynow,
    required this.pid,
    required this.sid,
  }) : super(key: key);

  @override
  State<DetilsScreen> createState() => DetilsScreenState();
}

class DetilsScreenState extends State<DetilsScreen> {
  @override
  // void initState() {
  //   razorpay = Razorpay();
  //   razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, onpaymentSuccess);
  //   razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, onpaymentFailed);
  //   razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  //   super.initState();
  //   super.initState();
  // }

  /// payment method on success
  // void onpaymentSuccess(PaymentSuccessResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Comman_Text(text: "Payment Done..!${response.signature}"),
  //     ),
  //   );
  // }
  //
  // /// payment method on failure
  // void onpaymentFailed(PaymentFailureResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Comman_Text(text: response.message.toString()),
  //     ),
  //   );
  // }
  //
  // /// payment method on wallet response
  // void onExternalWallet(ExternalWalletResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Comman_Text(text: response.walletName.toString()),
  //     ),
  //   );
  // }
  //
  // void openCheckOut() {
  //   var options = {
  //     'key': 'rzp_test_S3fVsCBL7e2hnh',
  //     'amount': int.parse(widget.price) * 100,
  //     'name': 'Fashion Hub',
  //     'description': 'Fine T-Shirt',
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'prefill': {'contact': '9925297076', 'email': 'ZeelSojitra00@gmail.com'},
  //     'external': {
  //       'wallets': ['paytm']
  //     },
  //   };
  //
  //   razorpay!.open(options);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        name: "Details",
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Product')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 2, bottom: 5),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            height: 400.sp,
                                            width: 250.sp,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Image.network(
                                              widget.image,
                                              // height: height(context) / 3,
                                              // width: width(context) / 2,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Comman_Text(
                                              text: "Product Name :",
                                              color: black,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: 'JV1',
                                            ),
                                            SizedBox(
                                              width: 8.sp,
                                            ),
                                            Flexible(
                                              child: Comman_Text(
                                                text: "${widget.name}",
                                                color: grey,
                                                fontSize: height(context) / 40,
                                                //fontFamily: 'JV1',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Comman_Text(
                                              text: "Rs :",
                                              color: black,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: 'JV1',
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Comman_Text(
                                              text: "${widget.price}₹",
                                              color: red,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: 'JV1',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Comman_Text(
                                              text: "Category:",
                                              color: black,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: 'JV1',
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Flexible(
                                              child: Comman_Text(
                                                text: "${widget.category}",
                                                color: grey,
                                                fontSize: height(context) / 40,
                                                fontWeight: FontWeight.w400,
                                                //fontFamily: 'JV1',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.01,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Comman_Text(
                                              text: "Product Descripation :",
                                              color: black,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: 'JV1',
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Comman_Text(
                                              text: "${widget.details}",
                                              color: grey,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: "JV1",
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Comman_Text(
                                              text: "Product Rating:",
                                              color: black,
                                              fontSize: height(context) / 40,
                                              fontWeight: FontWeight.w400,
                                              //fontFamily: 'JV1',
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            VxRating(
                                              value: 0,
                                              onRatingUpdate: (value) {},
                                              normalColor: green,
                                              selectionColor: yellow,
                                              size: height(context) * 0.03,
                                              count: 5,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Comman_Container(
                                                borderRadius:
                                                    BorderRadius.circular(5.sp),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: grey,
                                                    blurRadius: 5,
                                                    offset: Offset(2, 2),
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                                height: 40.sp,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Comman_Text(
                                                    color: white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        height(context) / 40,
                                                    text: "Add to card",
                                                    //fontFamily: "JV1",
                                                  ),
                                                ),
                                                color: red,
                                                ontap: () {
                                                  // List a = widget.AddToCart;
                                                  // if ((a).contains(widget.pid)) {
                                                  // } else {
                                                  //   a.add(widget.pid);
                                                  //   FirebaseFirestore.instance
                                                  //       .collection('Add_To_cart')
                                                  //       .doc(FirebaseAuth
                                                  //           .instance.currentUser!.uid)
                                                  //       .update({'AddToCart': a});
                                                  // }

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text("Add To Cart"),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                              Comman_Container(
                                                borderRadius:
                                                    BorderRadius.circular(5.sp),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: grey,
                                                    blurRadius: 5,
                                                    offset: Offset(2, 2),
                                                    spreadRadius: 1,
                                                  )
                                                ],
                                                height: 40.sp,
                                                width: double.maxFinite,
                                                child: Center(
                                                  child: Comman_Text(
                                                    color: white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        height(context) / 40,
                                                    text: "Buy Now",
                                                    //fontFamily: "JV1",
                                                  ),
                                                ),
                                                color: DarkGreen,
                                                ontap: () {
                                                  print("Address Screen");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddressDemo(
                                                        sid: widget.sid,
                                                        pid: widget.pid,
                                                        pprice: widget.price,
                                                        image: widget.image,
                                                        category:
                                                            widget.category,
                                                        details: widget.details,
                                                        name: widget.name,
                                                        price: widget.price,
                                                      ),
                                                    ),
                                                  );
                                                  //openCheckOut();
                                                  // List x = widget.buynow;
                                                  // if ((x).contains(widget.pid)) {
                                                  // } else {
                                                  //   x.add(widget.pid);
                                                  //   FirebaseFirestore.instance

//       .collection('user')
                                                  //       .doc(FirebaseAuth
                                                  //           .instance.currentUser!.uid)
                                                  //       .update({'buyNow': x});
                                                  // }
                                                },
                                              ),
                                              SizedBox(
                                                height: 10.sp,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
