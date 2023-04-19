import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:e_com/screens/Favorite_Screen.dart';
import 'package:e_com/screens/categories_screen.dart';
import 'package:e_com/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../globle/variable.dart';

class bottom_navigation_animated extends StatefulWidget {
  const bottom_navigation_animated({Key? key}) : super(key: key);

  @override
  State<bottom_navigation_animated> createState() =>
      _bottom_navigation_animatedState();
}

class _bottom_navigation_animatedState
    extends State<bottom_navigation_animated> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [
    Center(child: Text("Home")),
    CategoryScreen_2(),
    Favorite_Screen(),
    ProfileScreen(),
    //Center(child: Text("setting")),
    //Center(child: Text("profile")),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showLabel: false,
              notchColor: Color(0xff52B788),
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_outlined,
                    color: Color(0xff2D6A4F),
                  ),
                  activeItem: Icon(
                    Icons.home,
                    color: Color(0xffffffff),
                  ),
                  itemLabel: 'HOME',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.grid_view,
                    color: Color(0xff2D6A4F),
                  ),
                  activeItem: Icon(
                    Icons.grid_view_sharp,
                    color: Color(0xffffffff),
                  ),
                  itemLabel: 'category',
                ),

                ///svg example
                // BottomBarItem(
                //   inActiveItem: SvgPicture.asset(
                //     'asserts/svg/home-1-svgrepo-com.svg',
                //     color: Colors.blueGrey,
                //   ),
                //   activeItem: SvgPicture.asset(
                //     'asserts/svg/home-filled-svgrepo-com.svg',
                //     color: Colors.white,
                //   ),
                //   itemLabel: 'Page 3',
                // ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.favorite_outline,
                    color: Color(0xff2D6A4F),
                  ),
                  activeItem: Icon(
                    Icons.favorite,
                    color: Color(0xffffffff),
                  ),
                  itemLabel: 'Page 4',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person_outline,
                    color: Color(0xff2D6A4F),
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Color(0xffffffff),
                  ),
                  itemLabel: 'Page 5',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}

// class Page1 extends StatelessWidget {
//   const Page1({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.yellow, child: const Center(child: Text('Page 1')));
//   }
// }
//
// class Page2 extends StatelessWidget {
//   const Page2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.green, child: const Center(child: Text('Page 2')));
//   }
// }
//
// class Page3 extends StatelessWidget {
//   const Page3({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.red, child: const Center(child: Text('Page 3')));
//   }
// }
//
// class Page4 extends StatelessWidget {
//   const Page4({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.blue, child: const Center(child: Text('Page 4')));
//   }
// }
//
// class Page5 extends StatelessWidget {
//   const Page5({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.lightGreenAccent,
//         child: const Center(child: Text('Page 4')));
//   }
// }
