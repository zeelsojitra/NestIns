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
      this.textScaleFactor,
      //this.fontFamily,
      this.textAlign})
      : super(key: key);

  final text;
  //final fontFamily;
  final double? textScaleFactor;
  final int? maxLines;
  final Color? color;
  final decoration;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textScaleFactor: textScaleFactor,
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
