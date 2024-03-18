import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/pages/username.dart';
import 'package:mobile/features/auth/presentation/widgets/dialog.dart';

import '../bloc/signup/singup_bloc.dart';

class FinalConfirmationPage extends StatelessWidget {
  final ExtraUserName extra;
  const FinalConfirmationPage({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingupBloc, SingupState>(
      listener: (context, state) {
        if (state is SignUpError) {
          openDialog(context, state.message);
        }

        if (state is SignUpLoaded) {
          context.go('/login');
        }
      },
      builder: (context, state) {
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
                        "Agree to Instagram's terms and policies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "People who use our service maay have uploaded your contact information to Instagram. Learn more",
                        style: TextStyle(
                          color: const Color.fromARGB(200, 224, 219, 219),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "By tapping I agree, you agree to create an account and to Instagram's Terms, Privacy Policy and Cookies Policy.",
                        style: TextStyle(
                          color: const Color.fromARGB(200, 224, 219, 219),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "The Privacy Policy describe the ways we can use the information we collect when you create an account. For example we use this information to provide, personalize and improve our products. including ads",
                        style: TextStyle(
                          color: const Color.fromARGB(200, 224, 219, 219),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<SingupBloc>(context).add(
                            SignUpEven(
                              email: extra.email,
                              userName: extra.userName,
                              birthDate: extra.date,
                              password: extra.password,
                              fullName: extra.name,
                            ),
                          );
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
      },
    );
  }
}
