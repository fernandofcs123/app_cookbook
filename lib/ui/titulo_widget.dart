import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TituloWidget extends StatelessWidget {
  const TituloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa a largura total da tela
      child: Text(
        'Cook 📖 Book',
        textAlign: TextAlign.center, // Centraliza o texto horizontalmente
        style: GoogleFonts.cinzel( // ou o nome da fonte que estiver usando
          textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.black,
                fontSize: 40,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(2, 2)
                  ),
                ]
              ),
        ),
        maxLines: 1, // Garante que o texto não quebre
        overflow: TextOverflow.ellipsis, // Evita estouro de layout
      ),
    );
  }
}
