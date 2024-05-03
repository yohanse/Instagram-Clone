import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReelPostPageAfterSelect extends StatefulWidget {
  const ReelPostPageAfterSelect({super.key});

  @override
  State<ReelPostPageAfterSelect> createState() =>
      _ReelPostPageAfterSelectState();
}

class _ReelPostPageAfterSelectState extends State<ReelPostPageAfterSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () {
            context.go("/");
          },
        ),
        title: Text(
            "New Reel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
