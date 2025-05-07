import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/ui/video_card.dart';

class VideoFeedPage extends StatelessWidget {
  const VideoFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Query: todos os vídeos, ordenados por data decrescente
    final Stream<QuerySnapshot> feedStream = FirebaseFirestore.instance
      .collection('videos')
      .orderBy('data', descending: true)
      .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: feedStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nenhum vídeo disponível."));
          }

          // Converte cada doc num VideoModel e exibe VideoCard
          final videos = snapshot.data!.docs.map((doc) {
            return VideoModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: videos.length,
            itemBuilder: (_, i) => VideoCard(video: videos[i]),
          );
        },
      ),
    );
  }
}
