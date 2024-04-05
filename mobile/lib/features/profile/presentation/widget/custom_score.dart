import 'package:flutter/material.dart';

class CustomScore extends StatelessWidget {
  final String score, field;
  const CustomScore({super.key, required this.score, required this.field});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          score,
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          field,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
