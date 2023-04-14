import 'package:flutter/material.dart';

class Comman_Container extends StatelessWidget {
  const Comman_Container({
    Key? key,
    this.width,
    this.child,
    this.height,
    this.gradient,
    this.color,
    this.image,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.ontap,
    this.margin,
    this.alignment,
  }) : super(key: key);

  final double? width;
  final AlignmentGeometry? alignment;
  final child;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final color;
  final DecorationImage? image;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final boxShadow;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: alignment,
        width: width,
        margin: margin,
        height: height,
        child: child,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          image: image,
          borderRadius: borderRadius,
          border: border,
          boxShadow: boxShadow,
        ),
      ),
    );
  }
}
