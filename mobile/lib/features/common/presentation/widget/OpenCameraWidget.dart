import 'package:flutter/material.dart';

class OpenCameraWidget extends StatelessWidget {
  const OpenCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 85, 84, 84),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        Icons.camera_alt_rounded,
        color: Colors.white,
      ),
    );
  }
}
