// lib/modules/home/publicar_page.dart

import 'dart:io' show File, Platform;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_cookbook/services/nutrition_service.dart';

class PublicarPage extends StatefulWidget {
  const PublicarPage({super.key});

  @override
  State<PublicarPage> createState() => _PublicarPageState();
}

class _PublicarPageState extends State<PublicarPage> {
  final _tituloCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _receitaCtrl = TextEditingController();

  File? _videoFile;
  Uint8List? _videoBytes;
  String? _videoName;

  File? _thumbFile;
  Uint8List? _thumbBytes;
  String? _thumbName;

  String _nutritionText = '';
  bool _loadingNutrition = false;
  bool _isUploading = false;

  Future<bool> _requestAllStoragePermissions() async {
    if (kIsWeb) return true;
    final statuses = await [
      Permission.storage,      // Android ≤ 12
      Permission.photos,       // Android 13 (images) / iOS
      Permission.videos,       // Android 13 (videos)
    ].request();
    return statuses.values.any((status) => status.isGranted);
  }





  Future<void> _pickVideo() async {
    if (!await _requestAllStoragePermissions()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permissão de armazenamento negada.")));
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
      withData: kIsWeb,
    );

    if (result == null) return;
    final f = result.files.single;

    const int maxSizeInBytes = 20 * 1024 * 1024; // 20MB

    if (kIsWeb) {
      if (f.bytes != null && f.bytes!.lengthInBytes > maxSizeInBytes) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("O vídeo excede 20MB. Escolha outro arquivo.")),
        );
        return;
      }
      setState(() {
        _videoBytes = f.bytes;
        _videoFile = null;
        _videoName = f.name;
      });
    } else {
      final file = File(f.path!);
      final fileSize = await file.length();
      if (fileSize > maxSizeInBytes) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("O vídeo excede 20MB. Escolha outro arquivo.")),
        );
        return;
      }
      setState(() {
        _videoFile = file;
        _videoBytes = null;
        _videoName = f.name;
      });
    }
  }





  Future<void> _pickThumbnail() async {
  if (!await _requestAllStoragePermissions()) {
    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Permissão de galeria negada.")));
    return;
  }
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
    withData: kIsWeb,
  );
  if (result == null) return;
  final f = result.files.single;
  setState(() {
    _thumbName = f.name;
    if (kIsWeb) {
      _thumbBytes = f.bytes;
      _thumbFile  = null;
    } else {
      _thumbFile  = File(f.path!);
      _thumbBytes = null;
    }
  });
}




  Future _fetchNutrition() async {
    final text = _receitaCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _loadingNutrition = true;
      _nutritionText = '';
    });
    try {
      final resp = await NutritionService.getNutrition(text);
      setState(() => _nutritionText = resp);
      print(resp);
    } catch (e) {
      setState(() => _nutritionText = 'Erro ao gerar nutrição: $e');
    } finally {
      setState(() => _loadingNutrition = false);
    }
  }

  Future<void> _uploadAndSave() async {
    final user = FirebaseAuth.instance.currentUser;
    final titulo   = _tituloCtrl.text.trim();
    final descricao = _descricaoCtrl.text.trim();
    final receita   = _receitaCtrl.text.trim();

    // 1. Validações
    if ((_videoFile == null && _videoBytes == null) ||
        (_thumbFile == null && _thumbBytes == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione vídeo e thumbnail.")),
      );
      return;
    }
    if (titulo.isEmpty || descricao.isEmpty || receita.isEmpty) {
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
      // 2. Cria o DocumentReference vazio só para obter o ID
      final docRef = FirebaseFirestore.instance.collection('videos').doc();
      final videoId = docRef.id;
      final basePath = 'videos/${user.uid}/$videoId';

      // 3. Upload do vídeo
      final videoRef = FirebaseStorage.instance.ref('$basePath/video.mp4');
      final videoTask = kIsWeb
          ? await videoRef.putData(
              _videoBytes!,
              SettableMetadata(contentType: 'video/mp4'),
            )
          : await videoRef.putFile(_videoFile!);
      final videoUrl = await videoTask.ref.getDownloadURL();

      // 4. Upload da thumbnail
      final thumbRef = FirebaseStorage.instance.ref('$basePath/thumb.jpg');
      final thumbTask = kIsWeb
          ? await thumbRef.putData(
              _thumbBytes!,
              SettableMetadata(contentType: 'image/jpeg'),
            )
          : await thumbRef.putFile(_thumbFile!);
      final thumbUrl = await thumbTask.ref.getDownloadURL();

      // 5. Busca nome de usuário no Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();
      final nomeUsuario = userDoc.data()?['nome'] as String? ?? 'Usuário';

      // 6. Grava metadados usando o mesmo docRef
      await docRef.set({
        'uid'          : user.uid,
        'username'     : nomeUsuario,
        'profileImage' : user.photoURL ?? '',
        'titulo'       : titulo,
        'descricao'    : descricao,
        'receita'      : receita,
        'nutricao'     : _nutritionText,
        'thumbnailUrl' : thumbUrl,
        'videoUrl'     : videoUrl,
        'data'         : FieldValue.serverTimestamp(),
        'likes'        : 0,
        'comments'     : 0,
        'shares'       : 0,
      });

      await FirebaseFirestore.instance.collection('logs').add({
        'action'      : 'publish_video',
        'videoId'     : videoId,
        'userId'      : user.uid,
        'username'    : user.displayName ?? user.email,
        'videoUrl'    : videoUrl,
        'thumbnailUrl': thumbUrl,
        'timestamp'   : FieldValue.serverTimestamp(),
        'metadata'    : {
          'title': titulo,
          'description': descricao,
        },
      });


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Publicado com sucesso!')),
      );

      // 7. Limpa estado
      _tituloCtrl.clear();
      _descricaoCtrl.clear();
      _receitaCtrl.clear();
      setState(() {
        _videoFile    = null;
        _videoBytes   = null;
        _videoName    = null;
        _thumbFile    = null;
        _thumbBytes   = null;
        _thumbName    = null;
        _nutritionText = '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao publicar: $e')),
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
              GestureDetector(
                onTap: _pickVideo,
                child: SizedBox(
                  width: 200,
                  height: 200,
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

            
            
            const SizedBox(height: 16),
            TextField(
              controller: _tituloCtrl,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
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
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pie_chart),
                        SizedBox(width: 8),
                        Text('Gerar Informação Nutricional'),
                      ],
                    ),
            ),
            if (_nutritionText.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MarkdownBody(data: _nutritionText,),
              ),
            ],

            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Selecionar Thumbnail'),
              onPressed: _pickThumbnail,
            ),
            if (_thumbName != null) ...[
              const SizedBox(height: 8),
              Text('Thumbnail: $_thumbName'),
            ],
            
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isUploading ? null : _uploadAndSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromRGBO(205, 175, 149, 1),
                  foregroundColor: Colors.black,
                ),

                child:
                    _isUploading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Publicar  📖',
                          style: TextStyle(fontSize: 18),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
