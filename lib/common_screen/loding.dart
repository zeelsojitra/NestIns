import 'package:e_com/common_screen/Comman_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Comman_Container.dart';

class LodingDiloge extends StatelessWidget {
  const LodingDiloge({Key? key, this.message}) : super(key: key);

  final String? message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.sp),
            // circular progress bar
            child: Comman_Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                )),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Comman_Text(
            text: message.toString() + " Please wait...",
          )
        ],
      ),
    );
  }
}
