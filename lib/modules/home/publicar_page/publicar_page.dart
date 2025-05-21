// lib/modules/home/publicar_page.dart

import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_cookbook/services/nutrition_service.dart';

class PublicarPage extends StatefulWidget {
  const PublicarPage({Key? key}) : super(key: key);

  @override
  State<PublicarPage> createState() => _PublicarPageState();
}

class _PublicarPageState extends State<PublicarPage> {
  final _tituloCtrl    = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _receitaCtrl   = TextEditingController();

  File? _videoFile;
  Uint8List? _videoBytes;
  String? _videoName;

  String _nutritionText    = '';
  bool   _loadingNutrition = false;
  bool   _isUploading      = false;

  Future<bool> _requestStoragePermission() async {
    if (kIsWeb) return true;
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _pickVideo() async {
    if (!await _requestStoragePermission()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permissão de armazenamento negada.")),
      );
      return;
    }
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
      withData: kIsWeb,
    );
    if (result == null) return;
    final f = result.files.single;
    setState(() {
      _videoName = f.name;
      if (kIsWeb) {
        _videoBytes = f.bytes;
        _videoFile  = null;
      } else {
        _videoFile  = File(f.path!);
        _videoBytes = null;
      }
    });
  }

  Future<void> _fetchNutrition() async {
    final text = _receitaCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _loadingNutrition = true;
      _nutritionText    = '';
    });
    try {
      final resp = await NutritionService.getNutrition(text);
      setState(() => _nutritionText = resp);
    } catch (e) {
      setState(() => _nutritionText = 'Erro ao gerar nutrição: $e');
    } finally {
      setState(() => _loadingNutrition = false);
    }
  }

  Future<void> _uploadAndSave() async {
    final user      = FirebaseAuth.instance.currentUser;
    final titulo    = _tituloCtrl.text.trim();
    final descricao = _descricaoCtrl.text.trim();

    if (_videoFile == null && _videoBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione um vídeo.")),
      );
      return;
    }
    if (titulo.isEmpty || descricao.isEmpty || _receitaCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos.")),
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
      // upload vídeo
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${_videoName ?? 'video.mp4'}';
      final ref = FirebaseStorage.instance
          .ref()
          .child('videos/${user.uid}/$fileName');

      late TaskSnapshot task;
      if (kIsWeb) {
        task = await ref.putData(
          _videoBytes!,
          SettableMetadata(contentType: 'video/mp4'),
        );
      } else {
        task = await ref.putFile(_videoFile!);
      }
      final videoUrl = await task.ref.getDownloadURL();

      // busca nome do usuário
      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();
      final nomeUsuario = doc.data()?['nome'] as String? ?? 'Usuário';

      // salva no Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'uid'         : user.uid,
        'username'    : nomeUsuario,
        'profileImage': user.photoURL ?? '',
        'titulo'      : titulo,
        'descricao'   : descricao,
        'receita'     : _receitaCtrl.text.trim(),
        'nutricao'    : _nutritionText,
        'data'        : FieldValue.serverTimestamp(),
        'likes'       : 0,
        'comments'    : 0,
        'shares'      : 0,
        'videoUrl'    : videoUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Publicado com sucesso!")),
      );
      _tituloCtrl.clear();
      _descricaoCtrl.clear();
      _receitaCtrl.clear();
      setState(() {
        _videoFile     = null;
        _videoBytes    = null;
        _videoName     = null;
        _nutritionText = '';
      });
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Publicar vídeo',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // picker quadrado
            GestureDetector(
              onTap: _pickVideo,
              child: SizedBox(
                width: 200,   // largura fixa
                height: 200,  // altura fixa (mantém forma quadrada)
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _videoName == null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.play_arrow, size: 48, color: Colors.black54),
                              SizedBox(height: 8),
                              Text(
                                'Selecionar Vídeo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.videocam, size: 48, color: Colors.black54),
                              const SizedBox(height: 8),
                              Text(
                                _videoName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),


            // receita
            

            const SizedBox(height: 18),

            // título
            TextField(
              controller: _tituloCtrl,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // descrição
            TextField(
              controller: _descricaoCtrl,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _receitaCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingredientes e modo de preparo',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadingNutrition ? null : _fetchNutrition,
              child: _loadingNutrition
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Gerar Informação Nutricional com IA',style: TextStyle(fontSize: 15)),
            ),

            if (_nutritionText.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_nutritionText),
              ),
            ],
            const SizedBox(height: 16),

            // botão publicar
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isUploading ? null : _uploadAndSave,
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Publicar',style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
