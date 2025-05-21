// lib/models/video_model.dart

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
  });

  /// Construtor a partir de um DocumentSnapshot
  factory VideoModel.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return VideoModel(
      id:           doc.id,
      uid:          map['uid']        as String?   ?? '',
      username:     map['username']   as String?   ?? 'Usuário',
      profileImage: map['profileImage'] as String? ?? '',
      titulo:       map['titulo']     as String?   ?? '',
      descricao:    map['descricao']  as String?   ?? '',
      data:         (map['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likes:        map['likes']      as int?      ?? 0,
      comments:     map['comments']   as int?      ?? 0,
      shares:       map['shares']     as int?      ?? 0,
      videoUrl:     map['videoUrl']   as String?   ?? '',
    );
  }

  /// (Opcional) construtor a partir de um Map puro
  factory VideoModel.fromMap(String id, Map<String, dynamic> map) {
    return VideoModel(
      id:           id,
      uid:          map['uid']        as String?   ?? '',
      username:     map['username']   as String?   ?? 'Usuário',
      profileImage: map['profileImage'] as String? ?? '',
      titulo:       map['titulo']     as String?   ?? '',
      descricao:    map['descricao']  as String?   ?? '',
      data:         (map['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likes:        map['likes']      as int?      ?? 0,
      comments:     map['comments']   as int?      ?? 0,
      shares:       map['shares']     as int?      ?? 0,
      videoUrl:     map['videoUrl']   as String?   ?? '',
    );
  }
}
