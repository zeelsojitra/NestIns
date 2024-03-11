import 'package:e_com/src/view/category/category_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_com/src/constant/variable.dart';

import '../../widgets/comman_text.dart';

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
                    gradient:
                        const LinearGradient(colors: [darkGreen2, lightGreen]),
                    boxShadow: const [
                      BoxShadow(
                          color: grey, blurRadius: 4, offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(13)),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      CategoryScreen(
                        categoryName: categoriesDemo[index]['name'],
                      ),
                    );
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
    );
  }
}
