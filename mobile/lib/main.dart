import 'package:flutter/material.dart';
import 'package:mobile/instagram.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    const MaterialApp(
      home: InstagramApp(),
    ),
  );
}
