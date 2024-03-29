import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:e_com/src/widgets/comman_textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void search(String que) async {
    final result = await FirebaseFirestore.instance
        .collection("Product")
        .where('product_name', arrayContains: que)
        .get();

    searchresult = result.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  List searchresult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1),
            CommanTextFormFiled(
              onChanged: (query) {
                search(query);
              },
              hinttext: "Search",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchresult.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: CommanText(
                      //fontFamily: "JV1",
                      text: searchresult[index]["product_name"],
                    ),
                    subtitle: CommanText(
                        text: searchresult[index]["product_catagory"]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
