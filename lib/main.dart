import 'package:flutter/material.dart';

void main() {
  runApp(const CookBook());
}

class CookBook extends StatelessWidget {
  const CookBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cook Book'),
      ),
      body: const Center(
        child: Text('Welcome to the Cook Book!'),
      ),
    );
  }
}

class TelaPostar extends StatelessWidget {
  const TelaPostar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Postar'),
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título "Cook Book" com ícone de livro
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.book, size: 24, color: Colors.brown),
                  const SizedBox(width: 8),
                  const Text(
                    'Cook Book',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Área para o vídeo (placeholder)
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.play_circle_outline, size: 50, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 20),
            // Botão "Publicar Vídeo" com ícone de play
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação do botão (pode ser personalizada)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Publicar Vídeo clicado!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Campo de texto "nome do vídeo"
            TextField(
              decoration: InputDecoration(
                labelText: 'nome do vídeo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Campo de texto "descrição"
            TextField(
              decoration: InputDecoration(
                labelText: 'descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Permite várias linhas para descrição
            ),
            const SizedBox(height: 20),
            // Botão "Adicionar Filtros"
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Ação do botão
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adicionar Filtros clicado!')),
                  );
                },
                child: const Text('Adicionar Filtros'),
              ),
            ),
            const SizedBox(height: 20),
            // Botão "Publicar" na parte inferior
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação do botão
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Publicar clicado!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50), // Tamanho maior
                ),
                child: const Text('Publicar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


