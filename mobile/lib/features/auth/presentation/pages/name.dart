import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/pages/birth_date.dart';
import '../widgets/TextField.dart';
import '../widgets/dialog.dart';

// ignore: must_be_immutable
class NamePage extends StatelessWidget {
  final ExtraBirthDate extra;
  NamePage({super.key, required this.extra});
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
                    "What's your name?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextInput(
                    controller: nameController,
                    readOnly: false,
                    hintText: "Full name",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        context.go(
                            "/signup/confirmation/password/birthday/name/username", extra: ExtraName(name: nameController.text, email: extra.email, password: extra.password, date: extra.date),);
                      } else {
                        openDialog(context, "Please fill your full name.");
                      }
                    },
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
                onPressed: () {
                  context.go("/");
                },
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

class ExtraName {
  final String name, email, password;
  final DateTime date;

  ExtraName(
      {required this.name,
      required this.email,
      required this.password,
      required this.date});
}
