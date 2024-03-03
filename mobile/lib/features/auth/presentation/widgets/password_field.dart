import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const CustomPasswordField({super.key, required this.passwordController});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

bool obscure = true;

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      controller: widget.passwordController,
      style: TextStyle(
        fontSize: 16,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          color: Color.fromARGB(200, 224, 219, 219),
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        hintText: 'Password',
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
