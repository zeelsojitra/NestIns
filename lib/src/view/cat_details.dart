import 'package:flutter/material.dart';

class CatDemo extends StatefulWidget {
  final String? name, image, cat, details, price;

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
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
