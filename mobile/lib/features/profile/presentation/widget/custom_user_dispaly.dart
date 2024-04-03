import 'package:flutter/material.dart';

class CustomUserDisplay extends StatelessWidget {
  final String image, name;
  const CustomUserDisplay({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          CircleAvatar(
            child: Image(
              image: NetworkImage(image),
            ),
          ),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            "Suggested for you",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Follow",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
