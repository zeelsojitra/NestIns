import 'package:e_com/common_screen/Comman_TeextFiled.dart';
import 'package:e_com/common_screen/Comman_text.dart';
import 'package:e_com/globle/variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:sizer/sizer.dart';

class RoadMapScreen extends StatefulWidget {
  const RoadMapScreen({super.key});

  @override
  State<RoadMapScreen> createState() => _RoadMapScreenState();
}

class _RoadMapScreenState extends State<RoadMapScreen> {
  DateTime date = DateTime.now();
  int currentStep = 0;
  continueStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(DarkGreen),
            ),
            onPressed: details.onStepContinue,
            child: Comman_Text(
              text: 'Next',
              fontFamily: "JB1",
            ),
          ),
          SizedBox(width: Get.width * 0.05),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: Comman_Text(
              text: 'Back',
              fontFamily: "JB1",
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: AssetImage("asserts/image/DelivryPic.png"),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Comman_TexxtFiled(
                labletext: "Tracking Number",
                labelStyle: TextStyle(color: DarkGreen, fontFamily: "JB1"),
                hinttext: "E.g #120210120210",
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Comman_Text(
                    text: "Result:",
                    fontFamily: "JB1",
                    fontSize: 15.sp,
                  ),
                ],
              ),
              Stepper(
                controlsBuilder: controlBuilders,
                type: StepperType.vertical,
                physics: const ScrollPhysics(),
                onStepTapped: onStepTapped,
                onStepContinue: continueStep,
                onStepCancel: cancelStep,
                currentStep: currentStep, //0, 1, 2
                steps: [
                  Step(
                      title: Comman_Text(text: 'Ordered', fontFamily: "JB1"),
                      content: Comman_Text(
                          text: 'This is the First step.', fontFamily: "JV1"),
                      isActive: currentStep >= 0,
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                    title: Comman_Text(text: 'Packed', fontFamily: "JB1"),
                    content: Comman_Text(
                        text: 'This is the Second step.', fontFamily: "JV1"),
                    isActive: currentStep >= 0,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Comman_Text(text: 'Shipped', fontFamily: "JB1"),
                    content: Comman_Text(
                        text: 'This is the Second step.', fontFamily: "JV1"),
                    isActive: currentStep >= 0,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
