import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profileimg extends GetxController {
  File? image;
  ImagePicker picker = ImagePicker();
  String? imgshow;
  PickImage(ImageSource imageSource) async {
    final file = await picker.pickImage(source: imageSource);

    if (file != null) {
      image = File(file.path);
      SharedPreferences sh_img = await SharedPreferences.getInstance();
      sh_img.setString("Profile_Img", image.toString());
      if (sh_img.getString("Profile_Img") != null) {
        imgshow = sh_img.getString("Profile_Img");
      }
    }

    update();
  }
}
