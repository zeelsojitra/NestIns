import 'package:flutter/material.dart';

class CommanContainer extends StatelessWidget {
  const CommanContainer({
    super.key,
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
  });

  final double? width;
  final AlignmentGeometry? alignment;
  final Widget? child;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final Color? color;
  final DecorationImage? image;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
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
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          image: image,
          borderRadius: borderRadius,
          border: border,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
