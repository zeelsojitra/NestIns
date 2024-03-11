import 'package:e_com/src/widgets/comman_container.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LodingDiloge extends StatelessWidget {
  const LodingDiloge({super.key, this.message});

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
            child: const CommanContainer(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                )),
          ),
          SizedBox(
            height: 10.sp,
          ),
          CommanText(
            text: "$message Please wait...",
          )
        ],
      ),
    );
  }
}
