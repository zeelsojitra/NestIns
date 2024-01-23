import 'package:e_com/common_screen/comman_textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_text.dart';
import '../common_screen/comman_container.dart';
import '../globle/variable.dart';

class CategoryScreen2 extends StatefulWidget {
  const CategoryScreen2({super.key});

  @override
  State<CategoryScreen2> createState() => _CategoryScreen2State();
}

class _CategoryScreen2State extends State<CategoryScreen2> {
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
            // CommanContainer(
            //   height: 60.sp,
            //   width: double.infinity,
            //   borderRadius: BorderRadius.only(
            //       bottomRight: Radius.circular(30),
            //       bottomLeft: Radius.circular(30)),
            //   gradient: LinearGradient(
            //     colors: [
            //       darkGreen2,
            //       lightGreen,
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
            //         CommanText(
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
            CommanTextFormFiled(
              hinttext: "Search",
              controller: search,
              ontap: () {},
              onChanged: (p0) {
                searchText = p0;
                setState(() {});
              },
              prefixicon: const Icon(
                Icons.search_rounded,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: CommanContainer(
                          color: lightGreen,
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            onExpansionChanged: (value) {},
                            title: Row(
                              children: [
                                CommanText(
                                  text: categories[index]['title'],
                                  color: black,
                                  fontSize: 14.sp,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                )
                              ],
                            ),
                            subtitle: CommanText(
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
                              CommanContainer(
                                color: white,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Column(
                                  children: List.generate(
                                    inDetails[index]['cat'].length,
                                    (index1) => Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommanText(
                                            text: inDetails[index]['cat']
                                                    [index1]
                                                .toString(),
                                          ),
                                          const Icon(
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
