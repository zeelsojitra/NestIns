import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/screens/addressscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'common_screen/Comman_Container.dart';
import 'common_screen/Comman_text.dart';
import 'globle/media_query.dart';
import 'globle/variable.dart';

class CatData extends StatefulWidget {
  final String image, name, price, category, details, stock, pid, sid;
  final List buynow;
  const CatData(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.category,
      required this.details,
      required this.stock,
      required this.pid,
      required this.sid,
      required this.buynow})
      : super(key: key);

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
                    var data = snapshot.data!.docs;
                    return GridView.builder(
                      itemCount: categoriesDemo.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
