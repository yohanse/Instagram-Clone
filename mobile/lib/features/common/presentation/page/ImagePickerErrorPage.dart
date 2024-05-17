import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImagePickerErrorPage extends StatelessWidget {
  final String text;
  const ImagePickerErrorPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close_rounded),
            color: Colors.white,
            onPressed: () {
              context.go("/");
            },
          ),
          title: Text(
            "New post",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Text(text),
      ),
    );
  }
}
