import 'package:flutter/material.dart';

class CustomSelectMultipleWidget extends StatelessWidget {
  const CustomSelectMultipleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 85, 84, 84),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.copy_all_rounded,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text("SELECT MULTIPLE",
          style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
