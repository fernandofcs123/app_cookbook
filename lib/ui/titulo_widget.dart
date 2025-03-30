import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TituloWidget extends StatelessWidget {
  const TituloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Cook 📖 Book",
      style: GoogleFonts.cinzel(
        fontSize: 45, // Tamanho maior para o título
        fontWeight: FontWeight.bold,
        color: Colors.black,
        shadows: [
          Shadow(
            blurRadius: 4,
            color: Colors.black,
            offset: Offset(2, 2)
          ),
        ]
      ),
    );
  }
}