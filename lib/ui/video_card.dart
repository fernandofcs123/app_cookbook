import 'package:app_cookbook/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pacote necessário para formatar datas

class VideoCard extends StatelessWidget {
  final VideoModel video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat("dd/MM/yyyy").format(video.data);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Usuário
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(video.profileImage),
                ),
                const SizedBox(width: 10),
                Text(
                  video.username,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Miniatura do vídeo
            Container(
              height: 180,
              width: double.infinity,
              color: Colors.black12,
              child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 10),

            // Título
            Text(
              video.titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            // Data de publicação
            Text(
              'Publicado $dataFormatada',
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
