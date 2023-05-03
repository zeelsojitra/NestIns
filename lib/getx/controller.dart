import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Controller extends GetxController {
  File? image;
  int Addinfo_Selected = 0;
  String add_selected = "";
  bool like_btn = false;
  int onchange = 0;
  RxInt selectedScreen = 0.obs;
  RxInt On_Bording_onchange = 0.obs;
  // List likeList = [];
  RxBool signuploder = false.obs;
  RxBool signinploder = false.obs;
  RxInt logincheck = 0.obs;
  RxBool likeSelected = false.obs;

  Pageview(int value) {
    onchange = value;
    update();
  }

  AddInfo(int value) {
    Addinfo_Selected = value;

    update();
  }

  AddInfoWork(String value) {
    Addinfo_Selected = value as int;

    update();
  }

  ImagePicker picker = ImagePicker();
  PickImage(ImageSource imageSource) async {
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
