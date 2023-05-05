import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';

class Goa_pano_bhaju extends StatefulWidget {
  const Goa_pano_bhaju({Key? key}) : super(key: key);

  @override
  State<Goa_pano_bhaju> createState() => _Goa_pano_bhajuState();
}

class _Goa_pano_bhajuState extends State<Goa_pano_bhaju> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        name: "Category",
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where("product_catagory", isEqualTo: "Goa_pano_bhaju")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return snapshot.data!.docs.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        crossAxisCount: 2,
                        mainAxisExtent: 320),
                    itemBuilder: (context, index) {
                      final product = snapshot.data!.docs[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card( margin: EdgeInsets.only(top: 10.sp),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              color: grey,
                              child: Comman_Container(
                                borderRadius: BorderRadius.circular(5),
                                height: 155.sp,
                                width: double.infinity,
                                color: white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      product!['image'].toString()),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Comman_Text(
                              maxLines: 1,
                              text: product["product_name"],
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                            SizedBox(
                              height: 6.sp,
                            ),
                            Row(
                              children: [
                                Comman_Text(
                                  text: "₹",
                                  fontSize: 14.sp,
                                  color: black54,
                                ),
                                SizedBox(
                                  width: 2.sp,
                                ),
                                Comman_Text(
                                  text: product['product_price'],
                                  fontSize: 17.sp,
                                  color: red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Comman_Text(
                          text: "No Image Added!",
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "JB1",
                        ),
                        Comman_Text(
                          text: "Once you have added, come back:)",
                          fontSize: 19,
                          color: black54,
                          //fontFamily: "JB1",
                        ),
                      ],
                    ),
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
