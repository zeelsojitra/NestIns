// import 'package:e_com/screens/orderScreen.dart';
// import 'package:e_com/screens/profile_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sizer/sizer.dart';
// import '../common_screen/Comman_Container.dart';
// import '../common_screen/Comman_text.dart';
// import '../getx/controller.dart';
// import 'Favorite_Screen.dart';
// import 'categories_screen.dart';
// import 'fancy_drawer.dart';
// import 'home_screen.dart';
//
// class Bottom_navigation extends StatefulWidget {
//   const Bottom_navigation({Key? key}) : super(key: key);
//
//   @override
//   State<Bottom_navigation> createState() => _Bottom_navigationState();
// }
//
// class _Bottom_navigationState extends State<Bottom_navigation> {
//   final Controller controller = Get.put(Controller());
//   List items = [
//     {
//       "icon": Icon(Icons.home_outlined, color: Colors.black87),
//       "tap_icon": Icon(Icons.home, color: Color(0xff74C69D)),
//       "name": "Home",
//     },
//     {
//       "icon": Icon(Icons.grid_view, color: Colors.black87),
//       "tap_icon": Icon(Icons.grid_view_sharp, color: Color(0xff74C69D)),
//       "name": "Categories",
//     },
//     {
//       "icon": Icon(Icons.favorite_outline, color: Colors.black87),
//       "tap_icon": Icon(Icons.favorite, color: Color(0xff74C69D)),
//       "name": "Favourite",
//     },
//     {
//       "icon": Icon(Icons.person_outline, color: Colors.black87),
//       "tap_icon": Icon(Icons.person, color: Color(0xff74C69D)),
//       "name": "Profile",
//     },
//   ];
//   List Screens = [
//     HomeScreen1(),
//     CategoryScreen_2(),
//     Favorite_Screen(),
//     ProfileScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         body: Screens[controller.selectedScreen.value],
//         bottomNavigationBar: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Obx(
//               () => Comman_Container(
//                 child: Row(
//                   children: List.generate(
//                     items.length,
//                     (index) => Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 17.sp),
//                       child: InkWell(
//                         onTap: () {
//                           controller.selectedScreen.value = index;
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             controller.selectedScreen.value == index
//                                 ? items[index]['tap_icon']
//                                 : items[index]['icon'],
//                             Comman_Text(
//                               text: items[index]['name'],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 height: 52.sp,
//                 width: double.infinity,
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade300,
//                     blurRadius: 2,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//             ),
//             // Positioned(
//             //   top: -40,
//             //   right: 0,
//             //   child: GestureDetector(
//             //     onTap: () {
//             //       Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => OderScreen(),
//             //           ));
//             //     },
//             //     child: Comman_Container(
//             //       child: Padding(
//             //         padding: EdgeInsets.only(left: 6.sp),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //           children: [
//             //             Icon(
//             //               Icons.shopping_cart_outlined,
//             //               color: Colors.white,
//             //               size: 30,
//             //             ),
//             //             Column(
//             //               mainAxisAlignment: MainAxisAlignment.center,
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 Comman_Text(
//             //                   text: "\$199.89",
//             //                   color: Colors.white,
//             //                 ),
//             //                 Comman_Text(
//             //                   text: "Oder Screen",
//             //                   color: Colors.white,
//             //                   fontSize: 8.sp,
//             //                 ),
//             //               ],
//             //             )
//             //           ],
//             //         ),
//             //       ),
//             //       height: 45.sp,
//             //       width: 72.sp,
//             //       gradient: LinearGradient(
//             //         colors: [
//             //           Color(0xff2d6a4f),
//             //           Color(0xff95d5b2),
//             //         ],
//             //       ),
//             //       borderRadius: BorderRadius.horizontal(
//             //         left: Radius.circular(40),
//             //       ),
//             //     ),
//             //   ),
//             // ),`
//           ],
//         ),
//       ),
//     );
//   }
// }
