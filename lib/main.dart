import 'package:flutter/material.dart';
import 'downald_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const ExampleCupertinoDownloadButton(),
    );
  }
}
