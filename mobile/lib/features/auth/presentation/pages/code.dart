import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/check_email/check_email_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_confirmation/check_confirmation_bloc.dart';
import 'package:mobile/features/auth/presentation/widgets/dialog.dart';
import 'package:mobile/features/auth/presentation/widgets/six_digit_numerical.dart';

// ignore: must_be_immutable
class CodePage extends StatelessWidget {
  final String email;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  CodePage({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckConfirmationBloc, CheckConfirmationState>(
      listener: (context, state) {
        if (state is CheckConfirmationError) {
          openDialog(context, state.message);
        }
        if (state is CheckConfirmationLoaded) {
          if (state.isValid) {
            context.go("/signup/confirmation/password", extra: email);
          } else {
            openDialog(context, "Incorrect.");
          }
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
                        "Enter the confirmation code",
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
                        'To confirm your account, enter the 6-digit code we sent to ' +
                            email,
                        style: TextStyle(
                          color: const Color.fromARGB(200, 224, 219, 219),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomSixDigitInput(
                        controller1: controller1,
                        controller2: controller2,
                        controller3: controller3,
                        controller4: controller4,
                        controller5: controller5,
                        controller6: controller6,
                        readOnly: state is CheckConfirmationLoading,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                                print("Clicked Next");
                                BlocProvider.of<CheckConfirmationBloc>(context)
                                    .add(
                                  CheckConfirmationEven(
                                    email: email,
                                    code: controller1.text +
                                        controller2.text +
                                        controller3.text +
                                        controller4.text +
                                        controller5.text +
                                        controller6.text,
                                  ),
                                );
                              },
                        child: Text(
                          state is CheckConfirmationLoading ? " . . . .":"Next",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF0064E0)),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(email);
                          BlocProvider.of<CheckEmailBloc>(context).add(
                            CheckEmailEven(
                              email: email,
                            ),
                          );
                        },
                        child: Text(
                          state is CheckConfirmationLoading ? " . . . .":"I didn't get the code",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: const Color.fromARGB(200, 224, 219,
                                  219), // Set your desired border color
                              width: 0.5, // Set your desired border width
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF11222F)),
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
