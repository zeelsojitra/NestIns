import 'package:e_com/src/provider/getx/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeBtn extends StatelessWidget {
  LikeBtn({super.key, this.color, this.colorOutline, this.size, this.ontap});
  final Color? color;
  final Color? colorOutline;
  final void Function()? ontap;
  final double? size;
  final Controller contoller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: contoller.likeBtn == false
          ? Icon(
              Icons.favorite,
              color: color,
              size: size,
            )
          : Icon(
              Icons.favorite_outline_outlined,
              color: colorOutline,
              size: size,
            ),
    );
  }
}
