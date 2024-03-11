import 'package:e_com/src/constant/variable.dart';
import 'package:e_com/src/widgets/comman_text.dart';
import 'package:e_com/src/widgets/comman_textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RoadMapScreen extends StatefulWidget {
  const RoadMapScreen({super.key});
  @override
  State<RoadMapScreen> createState() => _RoadMapScreenState();
}

class _RoadMapScreenState extends State<RoadMapScreen> {
  DateTime? currentDate;
  DateTime date = DateTime.now();
  int currentStep = 0;
  //sahil

  continueStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    }

    if (currentStep == 3) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Product Added!")));
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

  @override
  void initState() {
    currentDate = DateTime.now();
    super.initState();
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const CommanText(
              text: 'Back',
              //fontFamily: "JB1",
              color: black,
            ),
          ),
          SizedBox(width: Get.width * 0.05),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(darkGreen),
            ),
            onPressed: details.onStepContinue,
            child: const CommanText(
              text: 'Next',
              //fontFamily: "JB1",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: coomanAppBar(
        name: "Order Status & Tracking",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  image: AssetImage("asserts/image/DelivryPic.png"),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              const CommanTextFormFiled(
                labletext: "Tracking Number",
                labelStyle: TextStyle(color: darkGreen, fontFamily: "JB1"),
                hinttext: "E.g #120210120210",
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommanText(
                    text: "Result:",
                    //fontFamily: "JB1",
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
                      title: const CommanText(
                        text: 'Ordered And Approved', //fontFamily: "JB1"
                      ),
                      subtitle: CommanText(
                        text: DateFormat("dd-MMM-yyyy").format(currentDate!),
                        //fontFamily: "JM1",
                      ),
                      content: const CommanText(
                        text: 'This is the First step.', //fontFamily: "JV1"
                      ),
                      isActive: currentStep >= 0,
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.complete),
                  Step(
                    title: const CommanText(
                      text: 'Packed',
                      // fontFamily: "JB1",
                    ),
                    subtitle: CommanText(
                      text: DateFormat("dd-MMM-yyyy").format(currentDate!),
                      //fontFamily: "JM1",
                    ),
                    content: const CommanText(
                      text: 'This is the Second step.', //fontFamily: "JV1",
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const CommanText(
                      text: 'Shipped',
                      //fontFamily: "JB1",
                    ),
                    subtitle: CommanText(
                      text: DateFormat("dd-MMM-yyyy").format(currentDate!),
                      //fontFamily: "JM1",
                    ),
                    content: const CommanText(
                      text: 'This is the Second step.',
                      //fontFamily: "JV1",
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const CommanText(
                      text: "Delivery",
                      //fontFamily: "JB1",
                    ),
                    subtitle: CommanText(
                      text: DateFormat("dd-MMM-yyyy").format(currentDate!),
                      //fontFamily: "JM1",
                    ),
                    content: CommanText(
                      text: DateFormat("dd-MM-yyyy").format(currentDate!),
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 3
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
