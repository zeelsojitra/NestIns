import 'package:e_com/screens/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../common_screen/Comman_text.dart';
import '../common_screen/comman_container.dart';
import '../getx/controller.dart';
import '../globle/variable.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetBuilder<Controller>(
            builder: (controller) => Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.sp, top: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.off(const TabBarScreen());
                            },
                            child: CommanText(
                              text: "Skip",
                              //fontFamily: "JB1",
                              fontWeight: FontWeight.bold,
                              color: black,
                              fontSize: 17.sp,
                            )),
                      ],
                    ),
                  ),
                  CommanContainer(
                    height: 400.sp,
                    width: width,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        controller.onBordingOnchange.value = value;
                      },
                      children: List.generate(
                        3,
                        (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              onbording[index]['img'],
                            ),
                            SizedBox(
                              height: 45.sp,
                            ),
                            CommanText(
                              color: black,
                              text: onbording[index]['name'],
                              fontWeight: FontWeight.bold,
                              //fontFamily: "JM1",
                              fontSize: 17.sp,
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CommanText(
                                color: grey,
                                text: onbording[index]['subtitle'],
                                fontWeight: FontWeight.bold,
                                //fontFamily: "JV1",
                                fontSize: 15.sp,
                              ),
                            ),
                            CommanText(
                              color: grey,
                              text: onbording[index]['subtitle2'],
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    controller.onBordingOnchange.value == index
                                        ? lightGreen
                                        : black,
                              ),
                            )),
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.onBordingOnchange.value == 1 ||
                                controller.onBordingOnchange.value == 2
                            ? Container(
                                height: 45.sp,
                                width: 45.sp,
                                decoration: const BoxDecoration(
                                  color: darkGreen2,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Icon(Icons.arrow_back,
                                      color: white, size: 27),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          height: 45.sp,
                          width: 45.sp,
                          decoration: const BoxDecoration(
                            color: darkGreen2,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (controller.onBordingOnchange.value == 2) {
                                Get.off(const TabBarScreen());
                              } else {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              }
                            },
                            child: const Icon(Icons.arrow_forward,
                                color: white, size: 27),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
