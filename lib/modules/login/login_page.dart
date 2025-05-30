import 'package:app_cookbook/ui/elevated_button_widget.dart';
import 'package:app_cookbook/ui/text_button_widget.dart';
import 'package:app_cookbook/ui/text_form_field_widget.dart';
import 'package:app_cookbook/ui/titulo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _login () async {
    if (_formKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _senhaController.text.trim(),
        );
        Navigator.of(context).pushReplacementNamed("/home");
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${e.message}")),
        );
      }
    }
  }

  void _cadastrar () {
      Navigator.of(context).pushNamed("/cadastrar");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // Título "Cook Book"
                  TituloWidget(),
                  const SizedBox(height: 100),

                  InputLoginWidget(
                    hint: "Email",
                    controller: _emailController,
                    validator: Validatorless.multiple([
                      Validatorless.email("E-mail inválido"),
                      Validatorless.required("Campo obrigatório"),
                    ]),
                  ),
                  const SizedBox(height: 30),

                  InputLoginWidget(
                    hint: "Senha",
                    controller: _senhaController,
                    obscure: true,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  const SizedBox(height: 30),

                  TextbuttonWidget(metodo: _cadastrar, nome: "Esqueci minha senha"),
                  const SizedBox(height: 10),

                  TextbuttonWidget(metodo: _cadastrar, nome: "Criar conta"),
                  const SizedBox(height: 60),

                  ElevatedbuttonWidget(
                    nome: "Login",
                    metodo: _login,
                    botaoKey: const Key("botao_login"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}