import 'package:flutter/material.dart';

import '../widgets/password_field.dart';

// ignore: must_be_immutable
class CreatePasswordPage extends StatelessWidget {
  CreatePasswordPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFF11222F),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create a password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create a password with at least 6 letters or numbers. It should be something others can't guess.",
                    style: TextStyle(
                      color: const Color.fromARGB(200, 224, 219, 219),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomPasswordField(
                    passwordController: passwordController,
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF0064E0),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Color(0xFF0064E0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}