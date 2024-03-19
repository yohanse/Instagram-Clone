import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/pages/create_password.dart';
import 'package:mobile/features/auth/presentation/widgets/date.dart';

import '../widgets/dialog.dart';

// ignore: must_be_immutable
class BirthDatePage extends StatelessWidget {
  final ExtraPassword extra;
  BirthDatePage({
    super.key,
    required this.extra,
  });
  TextEditingController dateController = TextEditingController();
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
                    "What's your birthday?",
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
                    "Use your own birthday, even if this account is for a business account, a pet or something else. No on will see this unless you choose to share it.",
                    style: TextStyle(
                      color: const Color.fromARGB(200, 224, 219, 219),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDate(
                    dateController: dateController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (dateController.text.isNotEmpty) {
                        context.go(
                          "/signup/confirmation/password/birthday/name",
                          extra: ExtraBirthDate(
                            email: extra.email,
                            password: extra.password,
                            date: DateTime.parse(dateController.text),
                          ),
                        );
                      } else {
                        openDialog(context, "Please fill your birthday.");
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

class ExtraBirthDate {
  final String email, password;
  final DateTime date;

  ExtraBirthDate(
      {required this.email, required this.password, required this.date});
}
