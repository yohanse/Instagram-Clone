import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericalInput extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  const NumericalInput(
      {super.key, required this.controller, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: 16,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          filled: true,
          fillColor: Color(0xFF1C2B33), // Set transparent background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Set border radius
            borderSide: BorderSide(
              color: const Color.fromARGB(200, 224, 219, 219), // Set border color
              width: 0.5, // Set border width
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: const Color.fromARGB(200, 224, 219, 219),
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: const Color.fromARGB(200, 224, 219, 219),
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
