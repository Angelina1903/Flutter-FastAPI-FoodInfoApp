import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String name;

  const DetailsPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Detail"),
      ),
      body: Center(
        child: Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}