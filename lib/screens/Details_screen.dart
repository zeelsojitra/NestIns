import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_Container.dart';
import 'package:e_com/globle/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        title: Comman_Text(
          text: "Detil's Screen",
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
          //               Icons.favorite_outline,
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
                                        Comman_Text(
                                          text: "${widget.name}",
                                          color: black,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        Comman_Text(
                                          text: "₨ :- ${widget.price}",
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        Comman_Text(
                                          text: "${widget.category}",
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        Comman_Text(
                                          text: "${widget.details}",
                                          color: grey,
                                          fontSize: height(context) / 35,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        VxRating(
                                          value: 0,
                                          onRatingUpdate: (value) {},
                                          normalColor: green,
                                          selectionColor: yellow,
                                          size: height(context) * 0.03,
                                          count: 5,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Comman_Container(
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                      spreadRadius: 1,
                                    )
                                  ],
                                  height: 60,
                                  width: 120,
                                  child: Center(
                                    child: Comman_Text(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: height(context) / 55,
                                      text: "Add to card",
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

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Add To Cart"),
                                      ),
                                    );
                                  },
                                ),
                                Comman_Container(
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                      spreadRadius: 1,
                                    )
                                  ],
                                  height: 60,
                                  width: 120,
                                  child: Center(
                                    child: Comman_Text(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: height(context) / 55,
                                      text: "Buy Now",
                                    ),
                                  ),
                                  color: amber,
                                  ontap: () {
                                    print("Address Screen");
                                    Get.to(
                                      AddressDemo(
                                        sid: widget.sid,
                                        pid: widget.pid,
                                        pprice: widget.price,
                                        image: widget.image,
                                        category: widget.category,
                                        details: widget.details,
                                        name: widget.name,
                                        price: widget.price,
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
                              ],
                            ),
                          ),
                        )
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
