import 'package:flutter/material.dart';
import 'search.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Info Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Urbanist"),
      home: const SearchPage(),
    );
  }
}
