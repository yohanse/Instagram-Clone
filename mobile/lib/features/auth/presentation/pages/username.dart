import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/check_username/check_username_bloc.dart';
import 'package:mobile/features/auth/presentation/pages/name.dart';
import '../widgets/username_field.dart';

// ignore: must_be_immutable
class UserNamePage extends StatelessWidget {
  final ExtraName extra;
  UserNamePage({super.key, required this.extra});
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckUsernameBloc, CheckUsernameState>(
      listener: (context, state) {},
      builder: (context, state) {
        Icon icon = Icon(
          Icons.check_circle,
          color: Colors.green,
        );
        if (state is CheckUsernameError) {
          icon = Icon(
            Icons.close,
            color: Colors.red,
          );
        }
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
                          controller: usernameController,
                          suffixIcon: state is CheckUsernameLoading
                              ? SizedBox(
                                  width: 5.0,
                                  height: 5.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Colors.white,
                                  ),
                                )
                              : icon,
                          hintText: "Username",
                          onChange: (username) {
                            BlocProvider.of<CheckUsernameBloc>(context).add(
                              CheckUsernameEven(
                                username: username,
                              ),
                            );
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (state is CheckUsernameLoaded && state.isValid) {
                            context.go(
                              '/signup/confirmation/password/birthday/name/username/finalConfirmation',
                              extra: ExtraUserName(
                                  userName: usernameController.text,
                                  email: extra.email,
                                  password: extra.password,
                                  name: extra.name,
                                  date: extra.date),
                            );
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
      },
    );
  }
}

class ExtraUserName {
  final String email, password, name, userName;
  final DateTime date;

  ExtraUserName(
      {required this.userName,
      required this.email,
      required this.password,
      required this.name,
      required this.date});
}
