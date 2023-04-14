import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../getx/controller.dart';
import 'Comman_Container.dart';

class Like_btn extends StatelessWidget {
  Like_btn({Key? key, this.color, this.color_outline, this.size, this.ontap})
      : super(key: key);
  final color;
  final color_outline;
  final void Function()? ontap;
  final size;
  final Controller contoller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: contoller.like_btn == false
          ? Icon(
              Icons.favorite,
              color: color,
              size: size,
            )
          : Icon(
              Icons.favorite_outline,
              color: color_outline,
              size: size,
            ),
    );
  }
}
