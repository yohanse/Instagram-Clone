import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/auth/domain/usecases/check_email_auth.dart';
import 'package:mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile/features/auth/presentation/pages/code.dart';

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
                    "What's your mobile number?",
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
                    "Enter the mobile number where you can be conducted. No one will see this on your profile.",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CodePage(),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextField(
                        controller: emailController,
                        readOnly: state is AuthLoading,
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(200, 224, 219, 219),
                          ),

                          filled: true,
                          fillColor: Color(
                              0xFF1C2B33), // Set transparent background color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set border radius
                            borderSide: BorderSide(
                              color: const Color.fromARGB(
                                  200, 224, 219, 219), // Set border color
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
                child: Text("Already have an account?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
