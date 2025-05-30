// lib/modules/home/perfil_page.dart

import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/ui/video_perfil_card.dart';
import 'package:app_cookbook/modules/home/video_page/video_detail_page.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final User _user = FirebaseAuth.instance.currentUser!;
  String? _localPhotoUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadAvatar() async {
    // 1) Escolhe imagem da galeria
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;

    // 2) Prepara referência no Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child('users/${_user.uid}/avatar.jpg');

    TaskSnapshot uploadTask;
    if (kIsWeb) {
      // Web: leia os bytes e envie com putData
      final bytes = await picked.readAsBytes();
      uploadTask = await ref.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } else {
      // Mobile: converta para File e envie com putFile
      final file = File(picked.path);
      uploadTask = await ref.putFile(file);
    }

    // 3) Pega URL pública
    final url = await uploadTask.ref.getDownloadURL();

    // 4) Atualiza Auth
    await _user.updatePhotoURL(url);

    // 5) Atualiza Firestore na coleção "usuarios"
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_user.uid)
        .update({'photoUrl': url});

    // 6) Atualiza UI local
    setState(() {
      _localPhotoUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Stream do documento do usuário
    final usuarioStream = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_user.uid)
        .snapshots();

    // Stream dos vídeos do usuário
    final videosStream = FirebaseFirestore.instance
        .collection('videos')
        .where('uid', isEqualTo: _user.uid)
        .orderBy('data', descending: true)
        .snapshots();

    return Scaffold(
      // backgroundColor: const Color(0xFFF6F0EB),
      body: Column(
        children: [
          const SizedBox(height: 24),

          // Cabeçalho com avatar clicável
          StreamBuilder<DocumentSnapshot>(
            stream: usuarioStream,
            builder: (context, snap) {
              if (!snap.hasData) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final data = snap.data!.data() as Map<String, dynamic>;
              final nome = data['nome'] as String? ?? 'Usuário';
              final username =
                  '@${data['email']?.split('@').first ?? _user.uid}';
              final photoUrl = _localPhotoUrl
                  ?? data['photoUrl'] as String?
                  ?? _user.photoURL;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _pickAndUploadAvatar,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: photoUrl != null
                            ? NetworkImage(photoUrl)
                            : const AssetImage('assets/icons/perfil.png')
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5, // limite de largura para evitar overflow
                          child: Text(
                            nome,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Seção "Vídeos"
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

          // Grid de vídeos
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: videosStream,
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snap.data!.docs;
                if (docs.isEmpty) {
                  return const Center(
                      child: Text("Você ainda não publicou vídeos."));
                }
                final videos =
                    docs.map((d) => VideoModel.fromDoc(d)).toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    itemCount: videos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.18,
                    ),
                    itemBuilder: (context, i) {
                      final vid = videos[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoDetailPage(video: vid),
                          ),
                        ),
                        child: VideoPerfilCard(video: vid),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
