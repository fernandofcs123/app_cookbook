// lib/ui/video_perfil_card.dart

import 'package:flutter/material.dart';
import 'package:app_cookbook/models/video_model.dart';

class VideoPerfilCard extends StatelessWidget {
  final VideoModel video;
  const VideoPerfilCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Miniatura
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Icon(Icons.play_arrow, size: 40, color: Colors.white70),
          ),

          // Título com padding menor e texto compacto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              video.titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
