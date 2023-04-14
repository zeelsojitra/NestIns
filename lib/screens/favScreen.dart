import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../globle/variable.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
          if (snap.hasData) {
            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Product').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs;
                        return (snap.data!['favourite'] as List)
                                .contains(data[index].id)
                            ? Column(
                                children: [
                                  Container(
                                    child: Comman_Text(
                                      text: '${data[index]['product_name']}',
                                    ),
                                    height: 200,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${data[index]['image']}'),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      List x = snap.data!['favourite'];
                                      if ((snap.data!['favourite'] as List)
                                          .contains(data[index].id)) {
                                        x.remove(data[index].id);
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({'favourite': x});
                                      } else {
                                        x.add(data[index].id);
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({'favourite': x});
                                      }
                                    },
                                    icon: (snap.data!['favourite'] as List)
                                                .contains(data[index].id) ==
                                            true
                                        ? Icon(
                                            Icons.favorite,
                                            color: (snap.data!['favourite']
                                                        as List)
                                                    .contains(data[index].id)
                                                ? red
                                                : grey,
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            color: (snap.data!['favourite']
                                                        as List)
                                                    .contains(data[index].id)
                                                ? red
                                                : grey,
                                          ),
                                  )
                                ],
                              )
                            : Container();
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
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
