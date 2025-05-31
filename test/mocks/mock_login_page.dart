import 'package:flutter/material.dart';

class MockLoginPage extends StatelessWidget {
  const MockLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final senhaController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            TextFormField(
              key: const Key('email_field'),
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('senha_field'),
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              key: const Key('botao_login'),
              onPressed: () {
                // Simula navegação ao clicar no botão de login
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: const Text('Login'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}