import 'package:flutter/material.dart';
import '../widgets/username_field.dart';

// ignore: must_be_immutable
class UserNamePage extends StatelessWidget {
  UserNamePage({super.key});
  TextEditingController nameController = TextEditingController();
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
                    "Create a username",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Add a username or use our suggestion. you can change this at any time.",
                    style: TextStyle(
                      color: const Color.fromARGB(200, 224, 219, 219),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  UsernameField(
                    controller: nameController,
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    hintText: "Username",
                  ),
                  SizedBox(
                    height: 15,
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
