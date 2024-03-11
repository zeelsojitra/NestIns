import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/utils/helper/pincode_json.dart';
import 'package:e_com/src/view/bottom_Navigation/bottom_navi_demo.dart';
import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:e_com/src/widgets/comman_textformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../provider/getx/controller.dart';

class AddressDemo extends StatefulWidget {
  final String pprice, pid, sid;
  final String image, name, price, category, details;
  const AddressDemo({
    super.key,
    required this.pprice,
    required this.pid,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.details,
    required this.sid,
  });

  @override
  State<AddressDemo> createState() => _AddressDemoState();
}

class _AddressDemoState extends State<AddressDemo> {
  DateTime date = DateTime.now();
  PincodeJson? pinJson;
  // String pincode = "",
  TextEditingController pincode = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  bool isPincode = false;
  DocumentReference buynowref =
      FirebaseFirestore.instance.collection("Order").doc();
  Razorpay? razorpay;

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, onpaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, onpaymentFailed);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
    super.initState();
    super.initState();
  }

  /// payment method on success
  void onpaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Done..!${response.signature}"),
      ),
    );
    log("date check$date");
    // FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("Order")
    //     .add({
    //   "sellerid": widget.sid,
    //   "image": widget.image,
    //   "product_catagory": widget.category,
    //   "product_details": widget.details,
    //   "product_name": widget.name,
    //   "product_price": widget.price,
    //   "UserId": FirebaseAuth.instance.currentUser!.uid,
    //   "PhoneNo": phone.text.toString(),
    //   "pincode": pincode.text.toString(),
    //   "city": city.text.toString(),
    //   "state": state.text.toString(),
    //   "house": house.text.toString(),
    //   "createdDate": "${date.day}-${date.month}-${date.year}",
    //   "road": road.text.toString(),
    //   "types add": contoller.add_selected.toString(),
    // }).then((value) {
    //   Get.to(Bottom_navigation());
    //   pincode.clear();
    //   city.clear();
    //   state.clear();
    //   phone.clear();
    //   house.clear();
    //   road.clear();
    // });
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Order").doc();
    docRef.set({
      "sellerid": widget.sid,
      "image": widget.image,
      "product_catagory": widget.category,
      "product_details": widget.details,
      "product_name": widget.name,
      "product_price": widget.price,
      "UserId": FirebaseAuth.instance.currentUser!.uid,
      "order id": docRef.id,
      "PhoneNo": phone,
      "pincode": pincode,
      "city": city,
      "state": state,
      "house": house.text.toString(),
      "road": road.text.toString(),
      "types add": contoller.addSelected.toString(),
      "createdDate": "${date.day}-${date.month}-${date.year}",
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        ),
      );
      pincode.clear();
      city.clear();
      state.clear();
      phone.clear();
      house.clear();
      road.clear();
    });

    // DocumentReference docref =
    //     FirebaseFirestore.instance.collection("Order").doc();
    // List x = widget.buynow;
    // if ((x).contains(widget.pid)) {
    // } else {
    //   x.add(widget.pid);
    //   FirebaseFirestore.instance
    //       .collection('Order')
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .update({'buyNow': x});
    //
    // }
  }

  /// payment method on failure
  void onpaymentFailed(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message.toString()),
      ),
    );
  }

  /// payment method on wallet response
  void onExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName.toString()),
      ),
    );
  }

  void openCheckOut() {
    var options = {
      'key': 'rzp_test_nIrj2lNM55W2mt',
      'amount': int.parse(widget.pprice) * 100,
      'name': 'NestIn',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9925297076', 'email': "Zeelsojitra00@gmail.com"},
      'external': {
        'wallets': ['paytm']
      },
    };

    razorpay!.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        name: "Product Detils",
        action: [
          TextButton(
            onPressed: () {
              phone.clear();
              pincode.clear();
              city.clear();
              state.clear();
              house.clear();
              road.clear();
            },
            child: CommanText(
              text: "Reset",
              color: white,
              //fontFamily: "JM1",
              fontSize: 15.sp,
            ),
          ),
          SizedBox(
            width: 15.sp,
          ),
        ],
      ),
      body: GetBuilder<Controller>(
        builder: (controller) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                    child: CommanText(
                      text: "Contact Info",
                      //fontFamily: "JM1",
                      fontSize: 18.sp,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 10.sp, right: 10.sp),
                    child: CommanTextFormFiled(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      fontFamily: "JM1",
                      controller: phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PhoneNo can not be empty';
                        }
                        return null;
                      },
                      hinttext: "phone Number (+91)",
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  const Divider(thickness: 2, color: Colors.black54),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: CommanText(
                      text: "Address Info",
                      fontSize: 18.sp,
                      //fontFamily: "JM1",
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        child: SizedBox(
                          height: 55.sp,
                          width: 134.sp,
                          child: CommanTextFormFiled(
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            fontFamily: "JM1",
                            onChanged: (value) {
                              if (value.length == 6) {
                                getData();
                                setState(() {});
                              }
                            },
                            hinttext: "PinCode",
                            controller: pincode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'PinCode can not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        child: SizedBox(
                          height: 55.sp,
                          width: 134.sp,
                          child: CommanTextFormFiled(
                            hinttext: "city",
                            controller: city,
                            fontFamily: "JM1",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'city can not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 10.sp, right: 10.sp),
                    child: CommanTextFormFiled(
                      hinttext: "State",
                      controller: state,
                      fontFamily: "JM1",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'State can not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 15.sp, right: 10.sp),
                    child: CommanTextFormFiled(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      hinttext: "house No., Building Name",
                      fontFamily: "JM1",
                      controller: house,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'house can not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 15.sp, right: 10.sp),
                    child: CommanTextFormFiled(
                      hinttext: "road name, Area, Colony",
                      controller: road,
                      fontFamily: "JM1",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'road can not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  const Divider(thickness: 2, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                    child: CommanText(
                      text: "Type of address",
                      fontSize: 18.sp,
                      color: black,
                      //fontFamily: "JM1",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
                    child: Row(
                      children: List.generate(addinfoAdd.length, (index) {
                        return CommanContainer(
                          ontap: () {
                            controller.addInfo(index);
                            if (index == 0) {
                              controller.addSelected = "Home";
                              log("Home");
                            } else {
                              controller.addSelected = "Work";
                              log("Work");
                            }
                          },
                          color: controller.addinfoSelected == index
                              ? darkGreen
                              : transparent,
                          margin: EdgeInsets.only(left: 10.sp),
                          height: 35.sp,
                          width: 100.sp,
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              addinfoAdd[index]['Icon'],
                              SizedBox(
                                width: 10.sp,
                              ),
                              Center(
                                child: CommanText(
                                  text: addinfoAdd[index]['Name'],
                                  //fontFamily: "JM1",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: controller.addinfoSelected == index
                                      ? white
                                      : black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 17.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 55,
                      color: darkGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: BorderSide.none),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          log("validate");

                          openCheckOut();

                          // List o = widget.Buynow;
                          // if ((o).contains(widget.pid)) {
                          // } else {
                          //   o.add(widget.pid);
                          //   FirebaseFirestore.instance
                          //       .collection('Order')
                          //       .doc(FirebaseAuth.instance.currentUser!.uid)
                          //       .set({'buyNow': o});
                          // }
                        }
                      },
                      child: CommanText(
                        text: "Submit",
                        color: Colors.white,
                        fontSize: 20.sp,
                        //fontFamily: "JM1"
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17.sp,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getData() async {
    pincode = pincode;
    var url = Uri.parse('http://www.postalpincode.in/api/pincode/$pincode');
    var response = await http.get(url);

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    Map<String, dynamic> map = jsonDecode(response.body);
    log(map['PostOffice']);

    pinJson = PincodeJson.fromJson(map);
    if (pinJson!.status == "Success") {
      city.text = pinJson!.postOffice![0].district!;
      state.text = pinJson!.postOffice![0].state!;
      isPincode = true;
    }

    setState(() {});
  }
}
