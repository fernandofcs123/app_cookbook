import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String profileImage;
  final String username;
  final String title;
  final int likes;
  final int comments;
  final int shares;
  final String uid;
  final String descricao;
  final DateTime data;     // melhor usar DateTime aqui

  VideoModel({
    required this.profileImage,
    required this.username,
    required this.title,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.uid,
    required this.descricao,
    required this.data,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      profileImage: map['profileImage'] as String? ?? '',
      username   : map['username']     as String? ?? 'Usuário',
      title      : map['titulo']       as String? ?? '',
      likes      : (map['likes']       as int?)    ?? 0,
      comments   : (map['comments']    as int?)    ?? 0,
      shares     : (map['shares']      as int?)    ?? 0,
      uid        : map['uid']          as String? ?? '',
      descricao  : map['descricao']    as String? ?? '',
      data       : (map['data']        as Timestamp).toDate(),
    );
  }
}
