import 'package:flutter/material.dart';

import 'numerical_filed.dart';

class CustomSixDigitInput extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  final TextEditingController controller5;
  final TextEditingController controller6;
  CustomSixDigitInput({
    super.key,
    required this.readOnly,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,
    required this.controller6,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumericalInput(controller: controller1, readOnly: readOnly),
        const SizedBox(
          width: 7,
        ),
        NumericalInput(controller: controller2, readOnly: readOnly),
        const SizedBox(
          width: 7,
        ),
        NumericalInput(controller: controller3, readOnly: readOnly),
        const SizedBox(
          width: 7,
        ),
        NumericalInput(controller: controller4, readOnly: readOnly),
        const SizedBox(
          width: 7,
        ),
        NumericalInput(controller: controller5, readOnly: readOnly),
        const SizedBox(
          width: 7,
        ),
        NumericalInput(controller: controller6, readOnly: readOnly),
      ],
    );
  }
}
