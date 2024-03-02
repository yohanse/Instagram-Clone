import 'package:flutter/material.dart';

Future openDialog(context, message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xFF11222F),
      title: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Color(0xFF0064E0),
            ),
          ),
        ),
      ],
    ),
  );
}
