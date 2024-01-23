import 'package:e_com/category/Gujrat_kediyu.dart';
import 'package:e_com/category/goa_pano_bhaju.dart';
import 'package:e_com/category/gujrat_bandhani.dart';
import 'package:e_com/category/gujrat_chaniyacoli.dart';
import 'package:e_com/category/gujrat_ghaghra.dart';
import 'package:e_com/category/gujrat_patola.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_com/globle/variable.dart';
import '../category/goa_dangar_topi.dart';
import '../category/goa_kunbi_saree.dart';
import '../category/chhattisgarh_dhoti_kurta.dart';
import '../category/chhattisgarh_paghadi.dart';
import '../category/chhattisgarh_saree.dart';
import '../category/haryana_dhoti.dart';
import '../category/haryana_ghaghra_choli.dart';
import '../category/haryana_kurta_payjama.dart';
import '../common_screen/Comman_text.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

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
            //                   child: CommanContainer(
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
            //                 CommanText(
            //                   text: product["product_name"],
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 15.sp,
            //                 ),
            //                 SizedBox(
            //                   height: 6.sp,
            //                 ),
            //                 Row(
            //                   children: [
            //                     CommanText(
            //                       text: "₹",
            //                       fontSize: 14.sp,
            //                       color: black54,
            //                     ),
            //                     SizedBox(
            //                       width: 2.sp,
            //                     ),
            //                     CommanText(
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
            //                       child: CommanContainer(
            //                         ontap: () {
            //                           log("tap");
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
            //                           child: CommanText(
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
                physics: const BouncingScrollPhysics(),
                itemCount: categoriesDemo.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15.sp),
                    child: Container(
                      height: Get.height * 0.062,
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                          // color: white,
                          gradient: const LinearGradient(
                              colors: [darkGreen2, lightGreen]),
                          boxShadow: const [
                            BoxShadow(
                                color: grey,
                                blurRadius: 4,
                                offset: Offset(2, 2))
                          ],
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () {
                          if (index == 0) {
                            Get.to(const ChhattisgarhDhotiKurta());
                          } else if (index == 1) {
                            Get.to(const ChhattisgarhPaghadi());
                          } else if (index == 2) {
                            Get.to(const ChhattisgarhSaree());
                          } else if (index == 3) {
                            Get.to(const GoaDangarTopi());
                          } else if (index == 4) {
                            Get.to(const GoaKunbiSaree());
                          } else if (index == 5) {
                            Get.to(const GoaPanoBhaju());
                          } else if (index == 6) {
                            Get.to(const GujratBandhani());
                          } else if (index == 7) {
                            Get.to(const GujratChaniyacoli());
                          } else if (index == 8) {
                            Get.to(const GujratGhaghra());
                          } else if (index == 9) {
                            Get.to(const GujratKediyu());
                          } else if (index == 10) {
                            Get.to(const GujratPatola());
                          } else if (index == 11) {
                            Get.to(const HaryanaDhoti());
                          } else if (index == 12) {
                            Get.to(const HaryanaGhaghraCholi());
                          } else if (index == 13) {
                            Get.to(const HaryanaKurtaPayjama());
                          }
                        },
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: white,
                        ),
                        leading: CommanText(
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
