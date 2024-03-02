import 'package:flutter/material.dart';

import 'numerical_filed.dart';

class CustomSixDigitInput extends StatelessWidget {
  final bool readOnly;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  CustomSixDigitInput({super.key, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumericalInput(controller: controller1, readOnly: readOnly),
        SizedBox(width: 7,),
        NumericalInput(controller: controller2, readOnly: readOnly),
        SizedBox(width: 7,),
        NumericalInput(controller: controller3, readOnly: readOnly),
        SizedBox(width: 7,),
        NumericalInput(controller: controller4, readOnly: readOnly),
        SizedBox(width: 7,),
        NumericalInput(controller: controller5, readOnly: readOnly),
        SizedBox(width: 7,),
        NumericalInput(controller: controller6, readOnly: readOnly),
      ],
    );
  }

  String getDigit() {
    return controller1.text +
        controller2.text +
        controller3.text +
        controller4.text +
        controller5.text +
        controller6.text;
  }
}
