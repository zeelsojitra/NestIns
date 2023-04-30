import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_Container.dart';
import 'package:e_com/globle/variable.dart';
import 'package:e_com/screens/Details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class searchpage extends StatefulWidget {
  const searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  String query = "";

  var result;

  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["product_name"].toLowerCase().contains(query) ||
          element["product_name"].toUpperCase().contains(query) ||
          element["product_name"].contains(query) ||
          element["product_name"].toLowerCase().contains(query) &&
              element["product_name"].contains(query) &&
              element["product_name"].toUpperCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  style: TextStyle(fontFamily: "JV1"),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.grey,
                    hintText: "Search Product Name",
                    hintStyle: TextStyle(fontFamily: "JV1"),
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                query == ""
                    ? Center(
                        child: Text(
                          '',
                          style: TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Product")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              var varData =
                                  searchFunction(query, snapshot.data!.docs);

                              return varData.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Product Found!",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "JB1",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: varData.length,
                                      itemBuilder: (context, index) {
                                        final product =
                                            snapshot.data!.docs[index];
                                        return GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                DetilsScreen(
                                                  sid: product['seller_id'],
                                                  pid: product['product_id'],
                                                  image: product['image'],
                                                  category: product[
                                                      "product_catagory"],
                                                  buynow: [],
                                                  details: product[
                                                      "product_details"],
                                                  name: product["product_name"],
                                                  price:
                                                      product["product_price"],
                                                  stock:
                                                      product['product_stock'],
                                                ),
                                              );
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              elevation: 5,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Comman_Container(
                                                        height: 120.sp,
                                                        width: 80.sp,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                              product["image"],
                                                            ),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                  // Center(
                                                  //   child: Image.network(
                                                  //     product["image"],
                                                  //     height: 140,
                                                  //   ),
                                                  // ),
                                                  SizedBox(height: 25),

                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Name : ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontFamily:
                                                                      "JM1"),
                                                            ),
                                                            Text(
                                                              product[
                                                                  "product_name"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: grey,
                                                                  fontFamily:
                                                                      "JV1"),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Catagory : ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontFamily:
                                                                      "JM1"),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                product[
                                                                    "product_catagory"],
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp,
                                                                    color: grey,
                                                                    fontFamily:
                                                                        "JV1"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Price : ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontFamily:
                                                                      "JM1"),
                                                            ),
                                                            Text(
                                                              product["product_price"] +
                                                                  "₹",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      "JV1"),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(height: 10),
                                                  // Text(
                                                  //   "  Name :  " +
                                                  //       data["first name"] +
                                                  //       " " +
                                                  //       data["last name"],
                                                  //   style:
                                                  //       TextStyle(fontSize: 20),
                                                  // ),
                                                  // SizedBox(height: 10),
                                                  // data["Payment_status"] == ""
                                                  //     ? SizedBox()
                                                  //     : Text(
                                                  //         "  Payment_status :  " +
                                                  //             data[
                                                  //                 "Payment_status"],
                                                  //         style: TextStyle(
                                                  //             fontSize: 20,
                                                  //             color: data["Payment_status"] ==
                                                  //                     "Done"
                                                  //                 ? Colors.green
                                                  //                 : data["Payment_status"] ==
                                                  //                         'cancel'
                                                  //                     ? Colors.red[
                                                  //                         900]
                                                  //                     : Colors
                                                  //                         .orange),
                                                  //       ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            ));
                                      });
                            }),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
