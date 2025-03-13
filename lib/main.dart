import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      home: Scaffold(
        backgroundColor: const Color(0xFFCDAF95), // Cor de fundo
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ), // Margem nas laterais
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centraliza verticalmente
              children: [
                // Título "Cook Book"
                const Text(
                  "Cook 📖 Book",
                  style: TextStyle(
                    fontSize: 45, // Tamanho maior para o título
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40), // Espaço entre título e campos
                // Campo de Email/Telefone
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email ou Telefone",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espaço entre os campos
                // Campo de Senha
                TextField(
                  obscureText: true, // Esconde a senha
                  decoration: InputDecoration(
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ), // Espaço antes do "Esqueci minha senha"
                // Texto "Esqueci minha senha"
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16, // Cor de link
                      decoration:
                          TextDecoration
                              .underline, // Sublinhado para parecer clicável
                    ),
                  ), // Não faz nada quando pressionado
                ),

                const SizedBox(height: 20), // Espaço antes do "Criar conta"
                // Texto "Criar conta como botão"
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Criar conta",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Espaço antes do botão
                // Botão de Login
                ElevatedButton(
                  onPressed: () {
                    // Aqui você pode adicionar a lógica de login depois
                    print("Botão de login pressionado!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Cor do botão
                    foregroundColor: Colors.black, // Cor do texto
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ), // Tamanho do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Bordas arredondadas
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
