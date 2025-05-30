import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

Future<void> uploadFile() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File file = File(pickedFile.path);
    try {
      final storageRef = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(file);
      print('Upload concluído!');
    } catch (e) {
      print('Erro ao enviar: $e');
    }
  }
}



Future<void> uploadVideo() async {
  final user = FirebaseAuth.instance.currentUser;

  // Selecionar o vídeo
  final result = await FilePicker.platform.pickFiles(type: FileType.video);
  if (result == null) return;

  final File videoFile = File(result.files.single.path!);
  final String fileName = path.basename(videoFile.path);

  // Caminho no Firebase Storage
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('videos/${user!.uid}/${DateTime.now().millisecondsSinceEpoch}_$fileName');

  // Fazer upload
  final uploadTask = await storageRef.putFile(videoFile);
  final videoUrl = await storageRef.getDownloadURL();

  // Salvar no Firestore
  await FirebaseFirestore.instance.collection('videos').add({
    'uid': user.uid,
    'username': user.displayName ?? 'Sem nome',
    'profileImage': user.photoURL ?? '',
    'titulo': 'Título do vídeo', // você pode pedir para o usuário digitar
    'descricao': 'Descrição do vídeo', // opcional
    'data': FieldValue.serverTimestamp(),
    'likes': 0,
    'comments': 0,
    'shares': 0,
    'videoUrl': videoUrl,
  });
}
