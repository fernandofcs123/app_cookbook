import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicarPage extends StatefulWidget {
  const PublicarPage({super.key});

  @override
  State<PublicarPage> createState() => _PublicarPageState();
}

class _PublicarPageState extends State<PublicarPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  Future<void> publicarVideo() async {
    final titulo = tituloController.text.trim();
    final descricao = descricaoController.text.trim();

    if (titulo.isEmpty || descricao.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Preencha todos os campos")));
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('videos').add({
        'titulo': titulo,
        'descricao': descricao,
        'data': Timestamp.now(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Publicado com sucesso!")));

      tituloController.clear();
      descricaoController.clear();
    } catch (err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao publicar: $err")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Correção para evitar overflow
        child: Padding(
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
                      const Icon(
                        Icons.play_arrow,
                        size: 60,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Publicar vídeo",
                        style: GoogleFonts.cinzel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: 'Título do vídeo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Adicionar filtros clicado!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Adicionar filtros',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: ElevatedButton(
                    onPressed: publicarVideo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Publicar',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
