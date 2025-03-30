import 'package:app_cookbook/ui/elevated_button_widget.dart';
import 'package:app_cookbook/ui/text_button_widget.dart';
import 'package:app_cookbook/ui/text_form_field_widget.dart';
import 'package:app_cookbook/ui/titulo_widget.dart';
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

  void _login () {
    if (_formKey.currentState!.validate()){
      Navigator.of(context).pushNamed("/home");
    }
  }

  void _cadastrar () {
      Navigator.of(context).pushNamed("/cadastrar");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDAF95), // Cor de fundo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center, // Centraliza verticalmente
              children: [
                // Título "Cook Book"
                  TituloWidget(),
                  const SizedBox(height: 150), 
                  
                  InputLoginWidget(hint: "Email ou Telefone", controller: _emailController,
                  validator: Validatorless.multiple([
                    Validatorless.email("E-mail inválido"),
                    Validatorless.required("Campo obrigatório")
                  ])),// Espaço entre título e campos
                  const SizedBox(height: 30), 
                  InputLoginWidget(hint: "Senha", controller: _senhaController, obscure: true,
                  validator: Validatorless.required("Campo obrigatório")),
                  
                  const SizedBox(height: 30,),
                  
                  TextbuttonWidget(metodo: _cadastrar, nome: "Esqueci minha senha"),
            
                  const SizedBox(height: 10,),
            
                  TextbuttonWidget(metodo: _cadastrar, nome: "Criar conta"),
            
                  
                  const SizedBox(height: 80), // Espaço antes do botão
                  
                  ElevatedbuttonWidget(nome: "Login", metodo: _login,)
                ],
              ),
            ),
          ),
        ),
      );
  }
}