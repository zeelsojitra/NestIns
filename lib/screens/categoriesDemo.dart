import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:e_com/globle/variable.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';

class CategoriesDemo extends StatefulWidget {
  const CategoriesDemo({Key? key}) : super(key: key);

  @override
  State<CategoriesDemo> createState() => _CategoriesDemoState();
}

class _CategoriesDemoState extends State<CategoriesDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
          Expanded(
            child: GridView.builder(
              itemCount: categoriesDemo.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  crossAxisCount: 2,
                  mainAxisExtent: 150),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                  child: Card(
                    elevation: 10,
                    child: Comman_Container(
                      ontap: () {
                        if (index == 0) {}
                      },
                      child: Center(
                        child: Comman_Text(
                          text: categoriesDemo[index]['name'],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
