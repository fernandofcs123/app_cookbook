import 'package:app_cookbook/app_cookbook.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final user = FirebaseAuth.instance.currentUser;

  // runApp(MaterialApp(
  //   home: user == null ? const LoginPage() : const MyHomePage(),
  // ));
  runApp(const AppCookbook());
}

