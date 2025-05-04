import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
