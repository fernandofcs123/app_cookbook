import 'package:flutter/material.dart';

class TextbuttonWidget extends StatelessWidget {

  final String nome;
  final VoidCallback metodo;


  const TextbuttonWidget({
    super.key,
    required this.metodo,
    required this.nome,

  });
  

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: metodo,
      child: Text(
        nome, 
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          decoration: TextDecoration.underline
        )),
    );
  }
}