import 'package:flutter/material.dart';

class Alternate extends StatelessWidget {
  const Alternate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alternate"),
      ),
      body: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
