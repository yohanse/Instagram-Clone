import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:mobile/features/auth/presentation/widgets/dialog.dart';

import '../widgets/TextField.dart';
import '../widgets/password_field.dart';

class LoginPage extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogInLoaded) {
          context.go("/finally");
        }

        if (state is LogInError) {
          openDialog(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: Color(0xFF11222F),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "English(US)",
                    style: TextStyle(
                      color: const Color.fromARGB(200, 224, 219, 219),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                SvgPicture.asset(
                  'assets/icons/instagram.svg',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  height: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextInput(
                      readOnly: false,
                      controller: usernameController,
                      hintText: "Username",
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
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          LogInEven(
                            username: usernameController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      child: Text(
                        "Login In",
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
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: const Color.fromARGB(200, 224, 219, 219),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go("/signup");
                  },
                  child: Text(
                    'Create new account',
                    style: TextStyle(
                      color: Color(0xFF0064E0),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Adjust as needed
                      side: BorderSide(color: Color(0xFF0064E0), width: 1.0),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
