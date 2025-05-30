import 'package:app_cookbook/modules/cadastro/cadastro_page.dart';
import 'package:app_cookbook/modules/home/home_page.dart';
import 'package:app_cookbook/modules/login/login_page.dart';
import 'package:flutter/material.dart';

class AppCookbook extends StatelessWidget {
  const AppCookbook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AppCookBook",
      routes: {
        '/':(_)=> LoginPage(),
        '/cadastrar':(_)=> CadastroPage(),
        '/home':(_)=> MyHomePage(),
      },
    );
  }
}