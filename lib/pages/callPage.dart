
import 'package:flutter/material.dart';

class Callpage extends StatelessWidget {
  const Callpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency')),
      body: const Center(
        child: Text('Emergency Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
