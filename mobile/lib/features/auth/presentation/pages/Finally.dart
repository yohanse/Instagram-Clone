import 'package:flutter/material.dart';

class Finally extends StatelessWidget {
  const Finally({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "You've successfully loged in or sing up.",
        ),
      ),
    );
  }
}
