import 'package:e_com/globle/variable.dart';
import 'package:flutter/material.dart';

import '../common_screen/Comman_text.dart';

class CatDemo extends StatefulWidget {
  final name, image, cat, details, price;

  const CatDemo(
      {super.key,
      required this.name,
      required this.image,
      required this.cat,
      required this.details,
      required this.price});

  @override
  State<CatDemo> createState() => _CatDemoState();
}

class _CatDemoState extends State<CatDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
