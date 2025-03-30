import 'package:flutter/material.dart';

class ElevatedbuttonWidget extends StatelessWidget {

  final String nome;
  final VoidCallback metodo;

  const ElevatedbuttonWidget({
    super.key,
    required this.nome,
    required this.metodo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: metodo,
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
      child: Text(
        nome,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}