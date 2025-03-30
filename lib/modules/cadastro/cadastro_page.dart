import 'package:app_cookbook/ui/elevated_button_widget.dart';
import 'package:app_cookbook/ui/text_form_field_widget.dart';
import 'package:app_cookbook/ui/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  void _cadastrar () {
    if (_formKey.currentState!.validate()){
      Navigator.of(context).pushNamed("/home");
    }
  }

  void _voltar () {
      Navigator.of(context).pushNamed("/");
  }

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDAF95), // Cor de fundo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ), // Margem nas laterais
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center, // Centraliza verticalmente
              children: [
                // Título "Cook Book"
                  TituloWidget(),
                  const SizedBox(height: 150), 
                  
                  InputLoginWidget(hint: "Nome", controller: _nomeController,
                  validator: Validatorless.required("Campo obrigatório")),// Espaço entre título e campos
                  const SizedBox(height: 10), 
                  InputLoginWidget(hint: "Telefone", controller: _telefoneController, isPhone: true,
                  validator: Validatorless.multiple([
                    Validatorless.phone("Número de telefone inválido"),
                    Validatorless.required("Campo obrigatório")
                  ])),
                  const SizedBox(height: 10), 
                  InputLoginWidget(hint: "E-mail", controller: _emailController,
                  validator: Validatorless.multiple([
                    Validatorless.email("E-mail inválido"),
                    Validatorless.required("Campo obrigatório")
                  ])),
                  const SizedBox(height: 10), 
                  InputLoginWidget(hint: "Senha", controller: _senhaController, obscure: true,
                  validator: Validatorless.required("Campo obrigatório")),
                  const SizedBox(height: 10), 
                  InputLoginWidget(hint: "Confirmar senha", controller: _confirmarSenhaController, obscure: true,
                    validator: Validatorless.multiple([
                    Validatorless.compare(_senhaController, "Senhas diferentes" ),
                    Validatorless.required("Campo obrigatório")
                  ])),
                  
                  const SizedBox(height: 50), 
                  
                  ElevatedbuttonWidget(nome: "   Criar   ", metodo: _cadastrar,),
                  const SizedBox(height: 15),
                  ElevatedbuttonWidget(nome: "Voltar", metodo: _voltar,),
            
            
                ],
              ),
          ),
          ),
        ),
      );
  }
}