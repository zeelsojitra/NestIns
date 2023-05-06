import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/globle/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../getx/controller.dart';
import '../screens/Favorite_Screen.dart';
import '../screens/categories_screen.dart';
import '../screens/fancy_drawer.dart';
import '../screens/profile_screen.dart';

// getx object
final Controller contoller = Get.put(Controller());

//color
const Color DarkGreen2 = Color(0xff2D6A4F);
const Color LightGreen1 = Color(0xff95d5d2);
const Color DarkGreen = Color(0xff40916C);
const Color LightGreen = Color(0xff52B788);
const Color lightGreen = Color(0xffB7E4C7);
const Color iconColor_Drawer = Color(0xffFFFFFF);
const Color iconColor = Color(0xff74C69D);
const Color orange_logo = Color(0xffF58634);
const Color green = Colors.green;
const Color purple = Colors.purple;
const Color pink = Colors.pink;
const Color deepOrange = Colors.deepOrange;
const Color teal = Colors.teal;
const Color yellow = Colors.yellow;
const Color amber = Colors.amber;
const Color grey = Colors.grey;
const Color red = Colors.red;
const Color white = Colors.white;
const Color white70 = Colors.white70;
const Color white60 = Colors.white60;
const Color black = Colors.black;
const Color black54 = Colors.black54;
const Color black87 = Colors.black87;
const Color black26 = Colors.black26;
const Color transparent = Colors.transparent;
// Color(0xff2D6A4F),//dark
// Color(0xff95D5B2),//light LightGreen1

//controller
final Phone = TextEditingController();
final Pincode = TextEditingController();
final City = TextEditingController();
final STATE = TextEditingController();
final House = TextEditingController();
final Road = TextEditingController();

//icon
const home_outlined = Icon(Icons.home_outlined, color: iconColor_Drawer);
const maps_home_work_sharp =
    Icon(Icons.maps_home_work_sharp, color: iconColor_Drawer);
const maps_home_work_sharp_Add =
    Icon(Icons.maps_home_work_sharp, color: LightGreen1);
const home = Icon(Icons.home, color: iconColor_Drawer);
const HomeAdd = Icon(
  Icons.home,
  color: LightGreen1,
);
const gridview = Icon(Icons.grid_view, color: iconColor_Drawer);
const logout = Icon(Icons.logout, color: iconColor_Drawer);
const privacy_tip_outlined =
    Icon(Icons.privacy_tip_outlined, color: iconColor_Drawer);
const share = Icon(Icons.share, color: iconColor_Drawer);
const favorite_outline = Icon(Icons.favorite_outline, color: iconColor_Drawer);
const shopping_cart_outlined =
    Icon(Icons.shopping_cart_outlined, color: iconColor_Drawer);

// image app logo

const logo_green = "asserts/logo/splash_main.png";
const main_logo = "asserts/logo/main_logo.png";
const text_logo = "asserts/logo/text_logo.png";
const Empty_order = "asserts/image/emptyorder.png";
const Empty_fav = "asserts/image/wishlist.png";

//categories image
const beauty_categories = "asserts/Categories/beauty.png";
const gadegts_categories = "asserts/Categories/gadegts.png";
const homekitchen_categories = "asserts/Categories/home & kitchen.png";
const kids_categories = "asserts/Categories/kids.png";
const men_categories = "asserts/Categories/men.png";
const men_shopping_categories = "asserts/Categories/men_shopping.png";
const wommen_categories = "asserts/Categories/wommen.png";

//categoriesdemo
//catlogue image
const computer_catlogue = "asserts/catlogue/computer.png";
const laptop_catlogue = "asserts/catlogue/laptop.png";
const men_catlogue = "asserts/catlogue/men.png";
const womens_catlogue = "asserts/catlogue/womens.png";
const kid_catlogue = "asserts/Categories/kids.png";

//login image
const apple_logo = "asserts/image/apple.png";
const apple_black_logo = "asserts/image/apple.png";
const app_bg = "asserts/image/bg.png";
const google_bg = "asserts/image/google.png";
const google_bg1 = "asserts/image/google_1.png";

//image shopping

const men_shopping = "asserts/image/men_shopping1.png";
const wommen_shopping = "asserts/Categories/wommen.png";

//pageview image
const page_view1 = "asserts/pageview/pageview1.jpg";
const page_view2 = "asserts/pageview/pageview2.jpg";
const page_view3 = "asserts/pageview/pageview3.jpg";
const page_view4 = "asserts/pageview/pageview4.jpg";
const page_view5 = "asserts/pageview/pageview5.jpg";
const page_view6 = "asserts/pageview/pageview6.jpg";
const page_view7 = "asserts/pageview/pageview7.jpg";
const page_view8 = "asserts/pageview/pageview8.jpg";

//onbording image
const onbording1 = "asserts/onbording/onbording1.png";
const onbording2 = "asserts/onbording/onbording2.png";
const onbording3 = "asserts/onbording/onbording3.png";

//lottie image
const apple_lottie = "asserts/lottie/apple.json";
const calling_lottie = "asserts/lottie/calling.json";
const google_lottie = "asserts/lottie/google.json";

//image checkout
const g = "asserts/checkout/masterCard.png";

//fav screen
const favorite_outline1 = Icon(Icons.favorite_outline, color: green);
const favorite = Icon(Icons.favorite_outline, color: red);
//drawer Screen
List drawer = [
  {
    "icon": home,
    "name": "Home",
  },
  {
    "icon": gridview,
    "name": "Shop by category",
  },
  {
    "icon": shopping_cart_outlined,
    "name": "Your Orders",
  },
  {
    "icon": favorite_outline,
    "name": "Your Wish List",
  },
  {
    "icon": share,
    "name": "Share",
  },
  // {
  //   "icon": privacy_tip_outlined,
  //   "name": "Privacy Policy",
  // },
  {
    "icon": logout,
    "name": "Logout",
  },
];

//global key
final formKey = GlobalKey<FormState>();

//List
List addinfo_add = [
  {
    "Icon": HomeAdd,
    "Name": "Home",
  },
  {
    "Icon": maps_home_work_sharp_Add,
    "Name": "Work",
  },
];

//details screen data

bool selected = false;
Razorpay? razorpay;
//categories screen data
List women_details = [
  "WesternWear",
  "IndianWear",
  "Jewellary",
  "FootWear",
  "Accessories",
];
List men_details = [
  "Clothing",
  "FootWear",
  "Watches",
  "Laggage",
  "Sports",
];
List kids_details = [
  "Boys",
  "Girls",
  "Babies",
  "FootWear",
  "Accessories",
];
List homeAndKitchen_details = [
  "Sofa",
  "BedSheets & more",
  "Lighting",
  "Wallpaper Stickers",
  "Home Furnishing",
  "Home Tools",
];
List beauty_details = [
  "SkinCare",
  "HairCare",
  "MackUp",
  "Fragrances",
  "Men's Grooming",
  "Women's Hygiene",
];
List gadgets_details = [
  "HeadPhones",
  "Cameras",
  "PowerBank",
  "Speakers",
  "Mobile Covers",
];
List categories = [
  {
    "title": "WOMEN",
    "subtitle": "Top & Tees, Kurtas & Suits... ",
    "imagess": wommen_categories,
  },
  {
    "title": "MEN",
    "subtitle": "T-Shirts, Shirts, Jeans, Shoes...",
    "imagess": men_categories,
  },
  {
    "title": "KIDS",
    "subtitle": "Clothing, Footwear, Brands...",
    "imagess": kids_categories,
  },
  // {
  //   "title": "HOME &\nKITCHEN",
  //   "subtitle": "Sofa, Bedsheets, Cushion...",
  //   "imagess": "asserts/Categories/home & kitchen.png",
  // },
  // {
  //   "title": "BEAUTY",
  //   "subtitle": "Makeup, Fragrances, Groom...",
  //   "imagess": "asserts/Categories/beauty.png",
  // },
  // {
  //   "title": "GADGETS",
  //   "subtitle": "Head phones, Mobile covers...",
  //   "imagess": "asserts/Categories/gadegts.png",
  // },
];
List In_details = [
  {
    'cat': [
      "WesternWear",
      "IndianWear",
      "Jewellary",
      "FootWear",
      "Accessories",
    ]
  },
  {
    'cat': [
      "Clothing",
      "FootWear",
      "Watches",
      "Laggage",
      "Sports",
    ]
  },
  {
    'cat': [
      "Boys",
      "Girls",
      "Babies",
      "FootWear",
      "Accessories",
    ]
  },
  {
    'cat': [
      "Sofa",
      "BedSheets & more",
      "Lighting",
      "Wallpaper Stickers",
      "Home Furnishing",
      "Home Tools",
    ]
  },
  {
    'cat': [
      "SkinCare",
      "HairCare",
      "MackUp",
      "Fragrances",
      "Men's Grooming",
      "Women's Hygiene",
    ]
  },
  {
    'cat': [
      "HeadPhones",
      "Cameras",
      "PowerBank",
      "Speakers",
      "Mobile Covers",
    ]
  },
];

// variable
final search = TextEditingController();

String searchText = "";

//home screen data

const String Fashionsale = "Fashion sale";
const String subtitile = "Seel More >";
Profileimg pi = Get.put(Profileimg());
//home screen
List Pageview = [
  page_view1,
  page_view2,
  page_view3,
  page_view4,
  page_view5,
  page_view6,
  page_view8,
  page_view7,
];
List Catalogue = [
  {
    'img': womens_catlogue,
    "name": "Women's\nFashion",
  },
  {
    'img': men_catlogue,
    "name": "Men's\nFashion",
  },
  {
    'img': kid_catlogue,
    "name": "Kids",
  },
  {
    'img': wommen_shopping,
    "name": "Girls",
  },
];
// List Featured = [
//   {
//     "id": 1,
//     "image": "asserts/gridview/gridview1.png",

//     "title": "Style Womens\nTurtleneck Oversized...",
//     "money": "\$49",
//     "money2": "\$99",
//   },
//   {
//     "id": 2,
//     "image": "asserts/gridview/gridview2.png",
//     "title": "Stylish Women Open\nFront Long Sleeve Ch...",
//     "money": "\$69.99",
//     "money2": "",
//   },
//   {
//     "id": 3,
//     "image": "asserts/gridview/gridview1.png",
//     "title": "Style Womens\nTurtleneck Oversized...",
//     "money": "\$49",
//     "money2": "\$99",
//   },
//   {
//     "id": 4,
//     "image": "asserts/gridview/gridview2.png",
//     "title": "Stylish Women Open\nFront Long Sleeve Ch...",
//     "money": "\$69.99",
//     "money2": "",
//   },
// ];;;;;;;;

int dot_selected = 0;
//bool selected = true;
File? image;
ImagePicker picker = ImagePicker();

//oder details

bool slectedFav = false;

//onbording
const String subtitle = "You just need to take a photo or upload and";
const String subtitle2 = "we will find similar products for you.";
List onbording = [
  {
    'img': onbording1,
    'name': "Online Order",
    'subtitle': "You can see the product with all angles,",
    "subtitle2": "true and convenient",
  },
  {
    'img': onbording2,
    'name': "Easy Payment",
    'subtitle': subtitle,
    "subtitle2": subtitle2,
  },
  {
    'img': onbording3,
    'name': "Fast Delivery",
    'subtitle': subtitle,
    "subtitle2": subtitle2,
  },
];
PageController pageController = PageController(initialPage: 0);
bool Selected = false;

//profile screen
// List profile = [
//   {
//     "name": "Shipping Addresses",
//     "Icon": Icon(
//       Icons.location_on_outlined,
//       //color: iconColor,
//     )
//   },
//   {
//     "name": "Payments Methods",
//     "Icon": Icon(
//       Icons.payments_sharp,
//       //color: iconColor,
//     )
//   },
//   {
//     "name": "Orders",
//     "Icon": Icon(
//       Icons.event_note_outlined,
//       //color: iconColor,
//     )
//   },
//   {
//     "name": "Favorite",
//     "Icon": Icon(
//       Icons.favorite_outline,
//       //color: iconColor,
//     ),
//   },
//   {
//     "name": "Settings",
//     "Icon": Icon(
//       Icons.settings,
//       // color: iconColor,
//     )
//   },
//   {
//     "name": "Log Out",
//     "Icon": Icon(
//       Icons.logout,
//       //color: iconColor,
//     )
//   },
// ];
List profile = [
  {
    "name": "Shipping Addresses",
    "Icon": Icons.location_on_outlined,
  },
  {
    "name": "Payments Methods",
    "Icon": Icons.payments_sharp,
  },
  {
    "name": "Orders",
    "Icon": Icons.event_note_outlined,
  },
  {
    "name": "Favorite",
    "Icon": Icons.favorite_outline,
  },
  {"name": "Settings", "Icon": Icons.settings},
  {
    "name": "Log Out",
    "Icon": Icons.logout,
  },
];

RegExp email = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp password =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

//categoreydemo screen
List categoriesDemo = [
  {
    "name": "chhattisgarh_dhoti_kurta",
  },
  {
    "name": "chhattisgarh_paghadi",
  },
  {
    "name": "chhattisgarh_saree",
  },
  {
    "name": "Goa_dangar_topi",
  },
  {
    "name": "Goa_kunbi-saree",
  },
  {
    "name": "Goa_pano_bhaju",
  },
  {
    "name": "Gujarat_bandhani",
  },
  {
    "name": "Gujarat_chaniya-choli",
  },
  {
    "name": "Gujarat_ghaghra",
  },
  {
    "name": "Gujarat_kediyu",
  },
  {
    "name": "Gujarat_patola",
  },
  {
    "name": "haryana_dhoti",
  },
  {
    "name": "haryana_ghaghra_choli",
  },
  {
    "name": "haryana_kurta_payjama",
  },
];

//comman app bar

AppBar coomanAppBar({String? name, List<Widget>? action, bool? centerTitle}) {
  return AppBar(
    title: Text("${name}"),
    centerTitle: centerTitle,
    titleTextStyle: TextStyle(fontFamily: "JS1", fontSize: Get.height * 0.022),
    actions: action,
    backgroundColor: DarkGreen2,
  );
}

// bottom navigation barr
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
List Screens = [
  HomeScreen1(),
  CategoryScreen_2(),
  Favorite_Screen(),
  ProfileScreen(),
];

String? demo;
