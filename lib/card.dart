import 'package:flutter/material.dart';

import 'globle/media_query.dart';

class Card extends StatefulWidget {
  const Card({Key? key}) : super(key: key);

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: GridView.builder(
          //       shrinkWrap: true,
          //       itemCount: 10,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           mainAxisSpacing: 15,
          //           //childAspectRatio: 10,
          //           crossAxisSpacing: 10,
          //           mainAxisExtent: 300),
          //       itemBuilder: (context, index) => Card(
          //         elevation: 10,
          //         child: Flexible(
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 20),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   height: height(context) * 0.17,
          //                   decoration: BoxDecoration(
          //                     color: Colors.black,
          //                     image: DecorationImage(
          //                       fit: BoxFit.cover,
          //                       image: NetworkImage(""),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Text("",
          //                     maxLines: 2,
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.w400,
          //                     )),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Container(
          //                   height: 30,
          //                   width: 60,
          //                   decoration: BoxDecoration(
          //                     color: Colors.green,
          //                     borderRadius: BorderRadius.circular(20),
          //                   ),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                     children: [
          //                       Text("",
          //                           maxLines: 2,
          //                           style: TextStyle(
          //                             color: Colors.white,
          //                             fontSize: 15,
          //                             fontWeight: FontWeight.w400,
          //                           )),
          //                       Icon(
          //                         Icons.star,
          //                         color: Colors.white,
          //                         size: 18,
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Text("",
          //                     maxLines: 2,
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.w400,
          //                     )),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
        // GestureDetector(
        //   onTap: () {
        //     Get.to(
        //       DetilsScreen(
        //         sid: product['seller_id'],
        //         pid: product['product_id'],
        //         buynow: snap.data!['buyNow'],
        //         image: product['image'],
        //         category: product["product_catagory"],
        //         details: product["product_details"],
        //         name: product["product_name"],
        //         price: product["product_price"],
        //         stock: product['product_stock'],
        //       ),
        //     );
        //   },
        //   child: Container(
        //     height: 155.sp,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       color: white,
        //       boxShadow: [
        //         BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: 1),
        //       ],
        //       borderRadius: BorderRadius.circular(15),
        //       image: DecorationImage(
        //         fit: BoxFit.cover,
        //         image: NetworkImage(product!['image'].toString()),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
