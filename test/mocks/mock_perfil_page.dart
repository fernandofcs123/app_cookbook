import 'package:flutter/material.dart';

class MockPerfilPage extends StatelessWidget {
  const MockPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockVideos = List.generate(4, (i) => 'Vídeo ${i + 1}');

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),

          // Cabeçalho simulado
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage('assets/icons/perfil.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bruno Aleixo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'bruno@aleixo',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Vídeos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Grid mock de vídeos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: mockVideos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.18,
                ),
                itemBuilder: (context, i) {
                  final title = mockVideos[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(),
                            body: Center(
                              child: Text('Detalhe de $title'),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.brown[100],
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
