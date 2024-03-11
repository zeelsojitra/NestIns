import 'dart:io';
import 'package:e_com/src/constant/profile_controller.dart';
import 'package:e_com/src/provider/getx/controller.dart';
import 'package:e_com/src/view/categories_screen.dart';
import 'package:e_com/src/view/fancy_drawer.dart';
import 'package:e_com/src/view/favorite_screen.dart';
import 'package:e_com/src/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// getx object
final Controller contoller = Get.put(Controller());

//color
const Color darkGreen2 = Color(0xff2D6A4F);
const Color lightGreen1 = Color(0xff95d5d2);
const Color darkGreen = Color(0xff40916C);
const Color lightGreen = Color(0xff52B788);
// const Color lightGreen = Color(0xffB7E4C7);
const Color iconColorDrawer = Color(0xffFFFFFF);
const Color iconColor = Color(0xff74C69D);
const Color orangeLogo = Color(0xffF58634);
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
// Color(0xff95D5B2),//light lightGreen1

//controller
final phone = TextEditingController();
final pincode = TextEditingController();
final city = TextEditingController();
final state = TextEditingController();
final house = TextEditingController();
final road = TextEditingController();

//icon
const homeOutlined = Icon(Icons.home_outlined, color: iconColorDrawer);
const mapsHomeWorkSharp =
    Icon(Icons.maps_home_work_sharp, color: iconColorDrawer);
const mapsHomeWorkSharpAdd =
    Icon(Icons.maps_home_work_sharp, color: lightGreen1);
const home = Icon(Icons.home, color: iconColorDrawer);
const homeAdd = Icon(
  Icons.home,
  color: lightGreen1,
);
const gridview = Icon(Icons.grid_view, color: iconColorDrawer);
const logout = Icon(Icons.logout, color: iconColorDrawer);
const privacyTipOutlined =
    Icon(Icons.privacy_tip_outlined, color: iconColorDrawer);
const share = Icon(Icons.share, color: iconColorDrawer);
const favoriteOutline = Icon(Icons.favorite_outline, color: iconColorDrawer);
const shoppingCartOutlined =
    Icon(Icons.shopping_cart_outlined, color: iconColorDrawer);

// image app logo

const logoGreen = "asserts/logo/splash_main.png";
const mainLogo = "asserts/logo/mainLogo.png";
const textLogo = "asserts/logo/text_logo.png";
const emptyOrder = "asserts/image/emptyorder.png";
const emptyFav = "asserts/image/wishlist.png";

//categories image
const beautyCategories = "asserts/Categories/beauty.png";
const gadegtsCategories = "asserts/Categories/gadegts.png";
const homekitchenCategories = "asserts/Categories/home & kitchen.png";
const kidsCategories = "asserts/Categories/kids.png";
const menCategories = "asserts/Categories/men.png";
const menShoppingCategories = "asserts/Categories/men_shopping.png";
const wommenCategories = "asserts/Categories/wommen.png";

//categoriesdemo
//catlogue image
const computerCatlogue = "asserts/catlogue/computer.png";
const laptopCatlogue = "asserts/catlogue/laptop.png";
const menCatlogue = "asserts/catlogue/men.png";
const womensCatlogue = "asserts/catlogue/womens.png";
const kidCatlogue = "asserts/Categories/kids.png";

//login image
const appleLogo = "asserts/image/apple.png";
const appleBlackLogo = "asserts/image/apple.png";
const appBg = "asserts/image/bg.png";
const googleBg = "asserts/image/google.png";
const googleBg1 = "asserts/image/google_1.png";

//image shopping

const menShopping = "asserts/image/men_shopping1.png";
const wommenShopping = "asserts/Categories/wommen.png";

//pageview image
const pageView1 = "asserts/pageview/pageview1.jpg";
const pageView2 = "asserts/pageview/pageview2.jpg";
const pageView3 = "asserts/pageview/pageview3.jpg";
const pageView4 = "asserts/pageview/pageview4.jpg";
const pageView5 = "asserts/pageview/pageview5.jpg";
const pageView6 = "asserts/pageview/pageview6.jpg";
const pageView7 = "asserts/pageview/pageview7.jpg";
const pageView8 = "asserts/pageview/pageview8.jpg";

//onbording image
const onbording1 = "asserts/onbording/onbording1.png";
const onbording2 = "asserts/onbording/onbording2.png";
const onbording3 = "asserts/onbording/onbording3.png";

//lottie image
const appleLottie = "asserts/lottie/apple.json";
const callingLottie = "asserts/lottie/calling.json";
const googleLottie = "asserts/lottie/google.json";

//image checkout
const g = "asserts/checkout/masterCard.png";

//fav screen
const favoriteOutline1 = Icon(Icons.favorite_outline, color: green);
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
    "icon": shoppingCartOutlined,
    "name": "Your Orders",
  },
  {
    "icon": favoriteOutline,
    "name": "Your Wish List",
  },
  {
    "icon": share,
    "name": "Share",
  },
  // {
  //   "icon": privacyTipOutlined,
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
List addinfoAdd = [
  {
    "Icon": homeAdd,
    "Name": "Home",
  },
  {
    "Icon": mapsHomeWorkSharpAdd,
    "Name": "Work",
  },
];

//details screen data

bool selected = false;
Razorpay? razorpay;
//categories screen data
List womenDetails = [
  "WesternWear",
  "IndianWear",
  "Jewellary",
  "FootWear",
  "Accessories",
];
List menDetails = [
  "Clothing",
  "FootWear",
  "Watches",
  "Laggage",
  "Sports",
];
List kidsdetails = [
  "Boys",
  "Girls",
  "Babies",
  "FootWear",
  "Accessories",
];
List homeAndKitchenDetails = [
  "Sofa",
  "BedSheets & more",
  "Lighting",
  "Wallpaper Stickers",
  "Home Furnishing",
  "Home Tools",
];
List beautyDetails = [
  "SkinCare",
  "HairCare",
  "MackUp",
  "Fragrances",
  "Men's Grooming",
  "Women's Hygiene",
];
List gadgetsDetails = [
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
    "imagess": wommenCategories,
  },
  {
    "title": "MEN",
    "subtitle": "T-Shirts, Shirts, Jeans, Shoes...",
    "imagess": menCategories,
  },
  {
    "title": "KIDS",
    "subtitle": "Clothing, Footwear, Brands...",
    "imagess": kidsCategories,
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
List inDetails = [
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

const String fashionsale = "Fashion sale";
const String subtitile = "Seel More >";
Profileimg pi = Get.put(Profileimg());
//home screen
List pageview = [
  pageView1,
  pageView2,
  pageView3,
  pageView4,
  pageView5,
  pageView6,
  pageView8,
  pageView7,
];
List catalogue = [
  {
    'img': womensCatlogue,
    "name": "Women's\nFashion",
  },
  {
    'img': menCatlogue,
    "name": "Men's\nFashion",
  },
  {
    'img': kidCatlogue,
    "name": "Kids",
  },
  {
    'img': wommenShopping,
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

int dotSelected = 0;
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
// bool Selected = false;

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
//       Icons.favoriteOutline,
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
    title: Text("$name"),
    centerTitle: centerTitle,
    titleTextStyle: TextStyle(fontFamily: "JS1", fontSize: Get.height * 0.022),
    actions: action,
    backgroundColor: darkGreen2,
    leading: const BackButton(
      color: white,
    ),
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
List screens = [
  const HomeScreen1(),
  const CategoryScreen2(),
  const FavoriteScreen(),
  const ProfileScreen(),
];

String? demo;
