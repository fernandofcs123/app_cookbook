import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String id;
  final String uid;
  final String username;
  final String profileImage;
  final String titulo;
  final String descricao;
  final DateTime data;
  final int likes;
  final int comments;
  final int shares;
  final String videoUrl;
  final String receita;
  final String thumbnailUrl;
  final String nutricao;

  VideoModel({
    required this.id,
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.videoUrl,
    required this.receita,
    required this.thumbnailUrl,
    required this.nutricao,
  });

  factory VideoModel.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return VideoModel(
      id: doc.id,
      uid: map['uid']        ?? '',
      username: map['username'] ?? 'Usuário',
      profileImage: map['profileImage'] ?? '',
      titulo: map['titulo']    ?? '',
      descricao: map['descricao'] ?? '',
      data: (map['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likes: map['likes']       ?? 0,
      comments: map['comments'] ?? 0,
      shares: map['shares']     ?? 0,
      videoUrl: map['videoUrl'] ?? '',
      receita: map['receita']   ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      nutricao: map['nutricao'] ?? '',
    );
  }
}