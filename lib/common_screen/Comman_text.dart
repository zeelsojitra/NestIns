import 'package:flutter/material.dart';

class Comman_Text extends StatelessWidget {
  const Comman_Text(
      {Key? key,
      this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.decoration,
      this.maxLines,
      this.textScaleFactor})
      : super(key: key);

  final text;
  final double? textScaleFactor;
  final int? maxLines;
  final Color? color;
  final decoration;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        decoration: decoration,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
