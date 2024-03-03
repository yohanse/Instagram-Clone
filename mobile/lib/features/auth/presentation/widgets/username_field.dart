import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget suffixIcon;
  const UsernameField(
      {super.key, required this.controller, required this.hintText, required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontSize: 16,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: const Color.fromARGB(200, 224, 219, 219),
        ),

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
    );
  }
}
