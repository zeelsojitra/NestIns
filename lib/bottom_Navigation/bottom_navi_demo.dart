import 'package:e_com/globle/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../getx/controller.dart';
import '../screens/Favorite_Screen.dart';
import '../screens/CategoriesScreen.dart';
import '../screens/categories_screen.dart';
import '../screens/fancy_drawer.dart';
import '../screens/profile_screen.dart';

class Bottom_navigation extends StatefulWidget {
  @override
  Bottom_navigationState createState() => Bottom_navigationState();
}

class Bottom_navigationState extends State<Bottom_navigation> {
  var currentIndex = 0;
  final Controller controller = Get.put(Controller());
  List Screens = [
    HomeScreen1(),
    CategoriesScreen(),
    Favorite_Screen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Screens[currentIndex],
      bottomNavigationBar: Container(
        // margin: EdgeInsets.symmetric(
        //     horizontal: displayWidth * .02, vertical: displayWidth * .015),
        height: displayWidth * .150,
        decoration: BoxDecoration(
          color: white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(.1),
          //     blurRadius: 30,
          //     offset: Offset(0, 10),
          //   ),
          // ],
          //borderRadius: BorderRadius.circular(40),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? DarkGreen2.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: DarkGreen2,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? DarkGreen2
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.grid_view_sharp,
    Icons.favorite_rounded,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Category',
    'Favorite',
    'Profile',
  ];
}
