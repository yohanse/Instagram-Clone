import 'package:flutter/material.dart';

class CustomUserDisplay extends StatelessWidget {
  final String image, name;
  const CustomUserDisplay({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(50, 255, 255, 255),
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Follow",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.close_rounded,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
