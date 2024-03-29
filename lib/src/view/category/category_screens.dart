import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/comman_container.dart';
import '../../widgets/comman_text.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        name: widget.categoryName,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where("product_catagory", isEqualTo: widget.categoryName)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            // var data = snapshot.data!.docs;
            return snapshot.data!.docs.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Card(
                              margin: EdgeInsets.only(top: 10.sp),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              color: grey,
                              child: CommanContainer(
                                borderRadius: BorderRadius.circular(5),
                                height: 155.sp,
                                width: double.infinity,
                                color: white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(product['image'].toString()),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            CommanText(
                              maxLines: 1,
                              text: product["product_name"],
                              //fontFamily: "JV1",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                            SizedBox(
                              height: 6.sp,
                            ),
                            Row(
                              children: [
                                CommanText(
                                  text: "₹",
                                  fontSize: 14.sp,
                                  //fontFamily: "JV1",
                                  color: black54,
                                ),
                                SizedBox(
                                  width: 2.sp,
                                ),
                                CommanText(
                                  text: product['product_price'],
                                  fontSize: 17.sp,
                                  color: red,
                                  //fontFamily: "JV1",
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  width: 2.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommanText(
                          text: "No Image Added!",
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "JB1",
                        ),
                        CommanText(
                          text: "Once you have added, come back:)",
                          fontSize: 19,
                          color: black54,
                          //fontFamily: "JB1",
                        ),
                      ],
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
