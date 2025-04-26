import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PublicarPage extends StatelessWidget {
  const PublicarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow, size: 60, color: Colors.black),
                    const SizedBox(height: 10),
                    Text(
                      "Publicar vídeo",
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'Título do vídeo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                

              ),
            ),
            const SizedBox(height: 20),
            // Campo de texto "descrição"
            TextField(
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              maxLines: 5, // Permite várias linhas para descrição
            ),
            const SizedBox(height: 30),
            // Botão "Adicionar Filtros"
            Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  
                  onPressed: () {
                    // Ação do botão
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Adicionar filtros clicado!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD9D9D9),
                    minimumSize: const Size(double.infinity, 50), // Tamanho maior
                  ),
                  child: const Text('Adicionar filtros', style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botão "Publicar" na parte inferior
            Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    // Ação do botão
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Publicar clicado!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD9D9D9),
                    minimumSize: const Size(double.infinity, 50), // Tamanho maior
                  ),
                  child: const Text('Publicar', style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}