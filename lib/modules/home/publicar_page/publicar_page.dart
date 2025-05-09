import 'dart:io'         show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PublicarPage extends StatefulWidget {
  const PublicarPage({Key? key}) : super(key: key);

  @override
  State<PublicarPage> createState() => _PublicarPageState();
}

class _PublicarPageState extends State<PublicarPage> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  // No mobile: File; no web: bytes
  File? _videoFile;
  Uint8List? _videoBytes;
  String? _videoName;

  bool _isUploading = false;

  Future<void> _pickVideo() async {
    // Mobile: pedir permissão
    if (!kIsWeb) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permissão de armazenamento negada.")),
        );
        return;
      }
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
      withData: kIsWeb,           // pega bytes no web
    );

    if (result == null) return;

    final file = result.files.single;
    setState(() {
      _videoName = file.name;
      if (kIsWeb) {
        _videoBytes = file.bytes;
        _videoFile = null;
      } else {
        _videoFile = File(file.path!);
        _videoBytes = null;
      }
    });
  }

  Future<void> _uploadAndSave() async {
    final user = FirebaseAuth.instance.currentUser;
    final titulo = tituloController.text.trim();
    final descricao = descricaoController.text.trim();

    if (_videoFile == null && _videoBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione um vídeo primeiro.")),
      );
      return;
    }
    if (titulo.isEmpty || descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha título e descrição.")),
      );
      return;
    }
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário não autenticado.")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${_videoName ?? 'video.mp4'}';
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('videos/${user.uid}/$fileName');

      late TaskSnapshot uploadTask;

      if (kIsWeb) {
        // Web: envia bytes
        uploadTask = await storageRef.putData(
          _videoBytes!,
          SettableMetadata(contentType: 'video/mp4'),
        );
      } else {
        // Mobile: envia File
        uploadTask = await storageRef.putFile(_videoFile!);
      }

      final videoUrl = await uploadTask.ref.getDownloadURL();

      final userDoc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .get();

      final nomeUsuario = userDoc.data()?['nome'] ?? 'Usuário';

      // Salva metadados no Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'uid'         : user.uid,
        'username'    : nomeUsuario,
        'profileImage': user.photoURL ?? '',
        'titulo'      : titulo,
        'descricao'   : descricao,
        'data'        : FieldValue.serverTimestamp(),
        'likes'       : 0,
        'comments'    : 0,
        'shares'      : 0,
        'videoUrl'    : videoUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Publicado com sucesso!")),
      );
      // limpa seleção
      setState(() {
        _videoFile = null;
        _videoBytes = null;
        _videoName = null;
      });
      tituloController.clear();
      descricaoController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao publicar: $e")),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publicar Vídeo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_library),
              label: const Text('Escolher Vídeo'),
            ),
            if (_videoName != null) ...[
              const SizedBox(height: 8),
              Text('Selecionado: $_videoName'),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título do vídeo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isUploading ? null : _uploadAndSave,
                child: _isUploading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Publicar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
