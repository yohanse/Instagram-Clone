import 'package:flutter/material.dart';
import 'package:mobile/instagram.dart';
import 'injection.dart' as di;

void main() async {
  await di.init();
  runApp(
    const MaterialApp(
      home: InstagramApp(),
    ),
  );
}
