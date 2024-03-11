import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profileimg extends GetxController {
  File? image;
  ImagePicker picker = ImagePicker();
  String? imgshow;
  pickImage(ImageSource imageSource) async {
    final file = await picker.pickImage(source: imageSource);

    if (file != null) {
      image = File(file.path);
      SharedPreferences shImg = await SharedPreferences.getInstance();
      shImg.setString("Profile_Img", image.toString());
      if (shImg.getString("Profile_Img") != null) {
        imgshow = shImg.getString("Profile_Img");
      }
    }

    update();
  }
}
