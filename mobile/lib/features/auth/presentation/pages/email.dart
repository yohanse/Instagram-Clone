import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile/features/auth/presentation/pages/code.dart';
import 'package:mobile/features/auth/presentation/widgets/TextField.dart';

class EmailPage extends StatelessWidget {
  EmailPage({super.key});
  TextEditingController emailController = TextEditingController();
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
                    "What's your email?",
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
                    "Enter the email where you can be conducted. No one will see this on your profile.",
                    style: TextStyle(
                      color: const Color.fromARGB(200, 224, 219, 219),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoaded && state.isValid) {
                        context.go('/confirmation', extra: emailController.text);
                      }
                    },
                    builder: (context, state) {
                      return CustomTextInput(
                        controller: emailController,
                        readOnly: state is AuthLoading,
                      );
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "you may receive SMS notifications from us for security and login purposes.",
                    style: TextStyle(
                      color: const Color.fromARGB(160, 224, 219, 219),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthCheckEmail(
                          email: emailController.text,
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF0064E0)),
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
