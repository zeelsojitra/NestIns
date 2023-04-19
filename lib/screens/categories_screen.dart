import 'package:e_com/common_screen/Comman_TeextFiled.dart';
import 'package:e_com/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_Container.dart';
import '../common_screen/Comman_text.dart';
import '../globle/variable.dart';

class CategoryScreen_2 extends StatefulWidget {
  const CategoryScreen_2({Key? key}) : super(key: key);

  @override
  State<CategoryScreen_2> createState() => _CategoryScreen_2State();
}

class _CategoryScreen_2State extends State<CategoryScreen_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        action: [],
        //centerTitle: true,
        name: "Categories",
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Comman_Container(
            //   height: 60.sp,
            //   width: double.infinity,
            //   borderRadius: BorderRadius.only(
            //       bottomRight: Radius.circular(30),
            //       bottomLeft: Radius.circular(30)),
            //   gradient: LinearGradient(
            //     colors: [
            //       DarkGreen2,
            //       LightGreen,
            //     ],
            //   ),
            //   child: Padding(
            //     padding:
            //         EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         InkWell(
            //             onTap: () {
            //               Get.back();
            //             },
            //             child: Icon(
            //               Icons.arrow_back,
            //               color: white,
            //               size: 30,
            //             )),
            //         Spacer(),
            //         Comman_Text(
            //           text: "Categories",
            //           color: white,
            //           fontSize: 20.sp,
            //           fontWeight: FontWeight.bold,
            //         ),
            //         Spacer(),
            //         SizedBox(
            //           width: 30.sp,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 10.sp,
            ),
            Comman_TexxtFiled(
              hinttext: "Search",
              controller: search,
              ontap: () {},
              onChanged: (p0) {
                searchText = p0;
                setState(() {});
              },
              prefixicon: Icon(
                Icons.search_rounded,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Comman_Container(
                          color: lightGreen,
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            onExpansionChanged: (value) {},
                            title: Row(
                              children: [
                                Comman_Text(
                                  text: categories[index]['title'],
                                  color: black,
                                  fontSize: 14.sp,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                )
                              ],
                            ),
                            subtitle: Comman_Text(
                              text: categories[index]['subtitle'],
                              color: black,
                              fontSize: 11.sp,
                            ),
                            trailing: Image.asset(
                              categories[index]['imagess'],
                              height: 150.sp,
                              width: 80.sp,
                              fit: BoxFit.fill,
                            ),
                            children: [
                              Comman_Container(
                                color: white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Column(
                                  children: List.generate(
                                    In_details[index]['cat'].length,
                                    (index1) => Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Comman_Text(
                                            text: In_details[index]['cat']
                                                    [index1]
                                                .toString(),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
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
