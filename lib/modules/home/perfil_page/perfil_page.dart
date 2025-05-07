import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/ui/video_perfil_card.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // Query: só meus vídeos
    final Stream<QuerySnapshot> meusVideosStream = FirebaseFirestore.instance
      .collection('videos')
      .where('uid', isEqualTo: uid)
      .orderBy('data', descending: true)
      .snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text("Meu Perfil")),
      body: StreamBuilder<QuerySnapshot>(
        stream: meusVideosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"),);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          print("Encontrei ${docs.length} videos para o uid $uid");
          if (docs.isEmpty) {
            return const Center(child: Text("Voce ainda nao publicou vídeos"),);
          }

          final meusVideos = docs
            .map((d) => VideoModel.fromMap(d.data() as Map<String, dynamic>))
            .toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: meusVideos.length,
            itemBuilder: (_, i) => VideoPerfilCard(video: meusVideos[i]),
          );
        },
      ),
    );
  }
}
