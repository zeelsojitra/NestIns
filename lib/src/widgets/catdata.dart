import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class CatData extends StatefulWidget {
  final String image, name, price, category, details, stock, pid, sid;
  final List buynow;
  const CatData(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.category,
      required this.details,
      required this.stock,
      required this.pid,
      required this.sid,
      required this.buynow});

  @override
  State<CatData> createState() => _CatDataState();
}

class _CatDataState extends State<CatData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return GridView.builder(
                      itemCount: categoriesDemo.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              crossAxisCount: 2,
                              mainAxisExtent: 150),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 10.sp),
                          child: Card(
                            elevation: 10,
                            child: CommanContainer(
                              ontap: () {
                                if (index == 0) {}
                              },
                              child: Center(
                                child: CommanText(
                                  text: categoriesDemo[index]['name'],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
