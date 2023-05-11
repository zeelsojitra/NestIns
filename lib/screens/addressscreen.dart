import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../bottom_Navigation/bottom_NAV.dart';
import '../bottom_Navigation/bottom_navi_demo.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_TeextFiled.dart';
import '../common_screen/Comman_text.dart';
import '../getx/controller.dart';
import '../globle/variable.dart';
import '../helper/pincodeJson.dart';
import 'bottom_navigation_screen.dart';
import 'home_screen.dart';

class AddressDemo extends StatefulWidget {
  final String pprice, pid, sid;
  final String image, name, price, category, details;
  const AddressDemo({
    Key? key,
    required this.pprice,
    required this.pid,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.details,
    required this.sid,
  }) : super(key: key);

  @override
  State<AddressDemo> createState() => _AddressDemoState();
}

class _AddressDemoState extends State<AddressDemo> {
  DateTime date = DateTime.now();
  pincodeJson? pinJson;
  String pincode = "",
      state = "",
      city = "",
      area = "",
      phone = "",
      no = "",
      error = "";
  bool isPincode = false;
  DocumentReference buynowref =
      FirebaseFirestore.instance.collection("Order").doc();
  Razorpay? razorpay;

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
    print("date check${date}");
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
    //   "PhoneNo": Phone.text.toString(),
    //   "pincode": Pincode.text.toString(),
    //   "city": City.text.toString(),
    //   "state": STATE.text.toString(),
    //   "house": House.text.toString(),
    //   "createdDate": "${date.day}-${date.month}-${date.year}",
    //   "road": Road.text.toString(),
    //   "types add": contoller.add_selected.toString(),
    // }).then((value) {
    //   Get.to(Bottom_navigation());
    //   Pincode.clear();
    //   City.clear();
    //   STATE.clear();
    //   Phone.clear();
    //   House.clear();
    //   Road.clear();
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
      "PhoneNo": Phone.text.toString(),
      "pincode": Pincode.text.toString(),
      "city": City.text.toString(),
      "state": STATE.text.toString(),
      "house": House.text.toString(),
      "road": Road.text.toString(),
      "types add": contoller.add_selected.toString(),
      "createdDate": "${date.day}-${date.month}-${date.year}",
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bottom_navigation(),
        ),
      );
      Pincode.clear();
      City.clear();
      STATE.clear();
      Phone.clear();
      House.clear();
      Road.clear();
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
              Phone.clear();
              Pincode.clear();
              City.clear();
              STATE.clear();
              House.clear();
              Road.clear();
            },
            child: Comman_Text(
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
                    child: Comman_Text(
                      text: "Contact Info",
                      //fontFamily: "JM1",
                      fontSize: 18.sp,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 10.sp, right: 10.sp),
                    child: Comman_TexxtFiled(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      fontFamily: "JM1",
                      controller: Phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PhoneNo can not be empty';
                        }
                      },
                      hinttext: "Phone Number (+91)",
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Divider(thickness: 2, color: Colors.black54),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: Comman_Text(
                      text: "Address Info",
                      fontSize: 18.sp,
                      //fontFamily: "JM1",
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        child: Container(
                          height: 55.sp,
                          width: 134.sp,
                          child: Comman_TexxtFiled(
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
                            controller: Pincode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'PinCode can not be empty';
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        child: Container(
                          height: 55.sp,
                          width: 134.sp,
                          child: Comman_TexxtFiled(
                            hinttext: "City",
                            controller: City,
                            fontFamily: "JM1",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'City can not be empty';
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 10.sp, right: 10.sp),
                    child: Comman_TexxtFiled(
                      hinttext: "State",
                      controller: STATE,
                      fontFamily: "JM1",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'State can not be empty';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 15.sp, right: 10.sp),
                    child: Comman_TexxtFiled(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      hinttext: "House No., Building Name",
                      fontFamily: "JM1",
                      controller: House,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'House can not be empty';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 15.sp, right: 10.sp),
                    child: Comman_TexxtFiled(
                      hinttext: "Road name, Area, Colony",
                      controller: Road,
                      fontFamily: "JM1",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Road can not be empty';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Divider(thickness: 2, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                    child: Comman_Text(
                      text: "Type of address",
                      fontSize: 18.sp,
                      color: black,
                      //fontFamily: "JM1",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
                    child: Row(
                      children: List.generate(addinfo_add.length, (index) {
                        return Comman_Container(
                          ontap: () {
                            controller.AddInfo(index);
                            if (index == 0) {
                              controller.add_selected = "Home";
                              print("Home");
                            } else {
                              controller.add_selected = "Work";
                              print("Work");
                            }
                          },
                          color: controller.Addinfo_Selected == index
                              ? DarkGreen
                              : transparent,
                          margin: EdgeInsets.only(left: 10.sp),
                          height: 35.sp,
                          width: 100.sp,
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              addinfo_add[index]['Icon'],
                              SizedBox(
                                width: 10.sp,
                              ),
                              Center(
                                child: Comman_Text(
                                  text: addinfo_add[index]['Name'],
                                  //fontFamily: "JM1",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: controller.Addinfo_Selected == index
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
                      color: DarkGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: BorderSide.none),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print("validate");

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
                      child: Comman_Text(
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
    pincode = Pincode.text;
    var url = Uri.parse('http://www.postalpincode.in/api/pincode/$pincode');
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> map = jsonDecode(response.body);
    print(map['PostOffice']);

    pinJson = pincodeJson.fromJson(map);
    if (pinJson!.status == "Success") {
      City.text = pinJson!.postOffice![0].district!;
      STATE.text = pinJson!.postOffice![0].state!;
      isPincode = true;
    }

    setState(() {});
  }
}
