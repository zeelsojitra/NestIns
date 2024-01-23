import 'package:flutter/material.dart';

class CommanText extends StatelessWidget {
  const CommanText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.decoration,
      this.maxLines,
      this.textScaleFactor,
      //this.fontFamily,
      this.textAlign});

  final String text;
  //final fontFamily;
  final double? textScaleFactor;
  final int? maxLines;
  final Color? color;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textScaler: TextScaler.linear(textScaleFactor ?? 1),
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: "JV1",
        decoration: decoration,
        color: color,
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
