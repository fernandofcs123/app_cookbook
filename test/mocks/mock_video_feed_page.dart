import 'package:flutter/material.dart';

class MockVideoFeedPage extends StatelessWidget {
  const MockVideoFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bolo de fuba de forno'), // <-- isso precisa bater com o que o teste procura
      ),
    );
  }
}
