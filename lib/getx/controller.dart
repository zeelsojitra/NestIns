import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Controller extends GetxController {
  File? image;
  int addinfoSelected = 0;
  String addSelected = "";
  bool likeBtn = false;
  int onchange = 0;
  RxInt selectedScreen = 0.obs;
  RxInt onBordingOnchange = 0.obs;
  // List likeList = [];
  RxBool signuploder = false.obs;
  RxBool signinploder = false.obs;
  RxInt logincheck = 0.obs;
  RxBool likeSelected = false.obs;

  pageview(int value) {
    onchange = value;
    update();
  }

  addInfo(int value) {
    addinfoSelected = value;

    update();
  }

  addInfoWork(String value) {
    addinfoSelected = value as int;

    update();
  }

  ImagePicker picker = ImagePicker();
  pickImage(ImageSource imageSource) async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      image = File(file.path);
      update();
    }
    update();
  }

  // void signuoloder(bool value) {
  //   signuploder = value;
  //   update();
  // }

  // setLikeList(int id) {
  //   if (likeList.contains(id)) {
  //     likeList.remove(id);
  //   } else {
  //     likeList.add(id);
  //   }
  //   update();
  // }
}
