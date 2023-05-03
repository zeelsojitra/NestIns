import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:e_com/globle/variable.dart';
import '../catdata.dart';
import '../category/Goa_dangar_topi.dart';
import '../category/Goa_kunbi_saree.dart';
import '../category/Goa_pano_bhaju.dart';
import '../category/Gujrat_bandhani.dart';
import '../category/Gujrat_chaniyacoli.dart';
import '../category/Gujrat_ghaghra.dart';
import '../category/Gujrat_kediyu.dart';
import '../category/Gujrat_patola.dart';
import '../category/chhattisgarh_dhoti_kurta.dart';
import '../category/chhattisgarh_paghadi.dart';
import '../category/chhattisgarh_saree.dart';
import '../category/haryana_dhoti.dart';
import '../category/haryana_ghaghra_choli.dart';
import '../category/haryana_kurta_payjama.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(name: "Category"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          children: [
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection('Product')
            //       .where("product_catagory", isEqualTo: "Gujrat_patola")
            //       .snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            //     if (snapshot.hasData) {
            //       var data = snapshot.data!.docs;
            //       return GridView.builder(
            //         shrinkWrap: true,
            //         itemCount: snapshot.data!.docs.length,
            //         physics: NeverScrollableScrollPhysics(),
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             mainAxisSpacing: 1,
            //             crossAxisSpacing: 1,
            //             crossAxisCount: 2,
            //             mainAxisExtent: 300),
            //         itemBuilder: (context, index) {
            //           final product = snapshot.data!.docs[index];
            //           return Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 10.sp),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Card(
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(20),
            //                   ),
            //                   elevation: 10,
            //                   color: grey,
            //                   child: Comman_Container(
            //                     borderRadius: BorderRadius.circular(5),
            //                     height: 155.sp,
            //                     width: double.infinity,
            //                     color: white,
            //                     image: DecorationImage(
            //                       fit: BoxFit.cover,
            //                       image:
            //                           NetworkImage(product!['image'].toString()),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 8.sp,
            //                 ),
            //                 Comman_Text(
            //                   text: product["product_name"],
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 15.sp,
            //                 ),
            //                 SizedBox(
            //                   height: 6.sp,
            //                 ),
            //                 Row(
            //                   children: [
            //                     Comman_Text(
            //                       text: "₹",
            //                       fontSize: 14.sp,
            //                       color: black54,
            //                     ),
            //                     SizedBox(
            //                       width: 2.sp,
            //                     ),
            //                     Comman_Text(
            //                       text: product['product_price'],
            //                       fontSize: 17.sp,
            //                       color: red,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection('user')
            //       .doc(FirebaseAuth.instance.currentUser!.uid)
            //       .snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
            //           snapshot) {
            //     if (snapshot.hasData) {
            //       return StreamBuilder(
            //         stream: FirebaseFirestore.instance
            //             .collection('Product')
            //             .snapshots(),
            //         builder: (BuildContext context,
            //             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
            //                 snapshot) {
            //           if (snapshot.hasData) {
            //             var data = snapshot.data!.docs;
            //             return Expanded(
            //               child: GridView.builder(
            //                 itemCount: categoriesDemo.length,
            //                 gridDelegate:
            //                     SliverGridDelegateWithFixedCrossAxisCount(
            //                         mainAxisSpacing: 1,
            //                         crossAxisSpacing: 1,
            //                         crossAxisCount: 2,
            //                         mainAxisExtent: 150),
            //                 itemBuilder: (context, index) {
            //                   return Padding(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 10.sp, vertical: 10.sp),
            //                     child: Card(
            //                       elevation: 10,
            //                       child: Comman_Container(
            //                         ontap: () {
            //                           print("tap");
            //                           Get.to(CatData(
            //                             image: data[index]['image'],
            //                             name: data[index]['product_name'],
            //                             sid: data[index]['seller_id'],
            //                             details: data[index]['product_details'],
            //                             category: data[index]['product_catagory'],
            //                             price: data[index]['product_price'],
            //                             pid: data[index]['product_id'],
            //                             stock: data[index]['product_stock'],
            //                             buynow: [],
            //                           ));
            //                         },
            //                         child: Center(
            //                           child: Comman_Text(
            //                             text: categoriesDemo[index]['name'],
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             );
            //           } else {
            //             return Center(child: CircularProgressIndicator());
            //           }
            //         },
            //       );
            //     } else {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            // ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: categoriesDemo.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15.sp),
                    child: Container(
                      height: Get.height * 0.062,
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                          // color: white,
                          gradient:
                              LinearGradient(colors: [DarkGreen2, LightGreen]),
                          boxShadow: [
                            BoxShadow(
                                color: grey,
                                blurRadius: 4,
                                offset: Offset(2, 2))
                          ],
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () {
                          if (index == 0) {
                            Get.to(chhattisgarh_dhoti_kurta());
                          } else if (index == 1) {
                            Get.to(chhattisgarh_paghadi());
                          } else if (index == 2) {
                            Get.to(chhattisgarh_saree());
                          } else if (index == 3) {
                            Get.to(Goa_dangar_topi());
                          } else if (index == 4) {
                            Get.to(Goa_kunbi_saree());
                          } else if (index == 5) {
                            Get.to(Goa_pano_bhaju());
                          } else if (index == 6) {
                            Get.to(Gujrat_bandhani());
                          } else if (index == 7) {
                            Get.to(Gujrat_chaniyacoli());
                          } else if (index == 8) {
                            Get.to(Gujrat_ghaghra());
                          } else if (index == 9) {
                            Get.to(Gujrat_kediyu());
                          } else if (index == 10) {
                            Get.to(Gujrat_patola());
                          } else if (index == 11) {
                            Get.to(haryana_dhoti());
                          } else if (index == 12) {
                            Get.to(haryana_ghaghra_choli());
                          } else if (index == 13) {
                            Get.to(haryana_kurta_payjama());
                          }
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: white,
                        ),
                        leading: Comman_Text(
                          //fontFamily: "JV1",
                          text: categoriesDemo[index]['name'],
                          fontSize: 15.sp,
                          color: white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
