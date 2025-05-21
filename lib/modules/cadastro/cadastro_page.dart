import 'package:app_cookbook/ui/elevated_button_widget.dart';
import 'package:app_cookbook/ui/text_form_field_widget.dart';
import 'package:app_cookbook/ui/titulo_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _cadastrar () async {
    if (_formKey.currentState!.validate()){
      try {
        final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _senhaController.text.trim(),
        );

        await FirebaseFirestore.instance.collection("usuarios").doc(cred.user!.uid).set({
          'nome': _nomeController.text.trim(),
          'telefone': _telefoneController.text.trim(),
          'email': _emailController.text.trim(),
        });
        Navigator.of(context).pushReplacementNamed("/home");
        
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${e.message}")),
        );
      }
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

                  const SizedBox(height: 100), 

                  Text(
                    "Criar nova conta",
                    style: GoogleFonts.cinzel(
                      fontSize: 22, // Tamanho maior para o título
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      
                    ),
                  ),

                  const SizedBox(height: 45), 
                  
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
                    Validatorless.required("Campo obrigatório"),
                    (value) {
                      if (value != null && value.contains(" ")) {
                        return "Não pode conter espaços";
                      }
                      return null;
                    }
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
                  
                  ElevatedbuttonWidget(nome: "   Criar   ", metodo: _cadastrar, botaoKey: const Key("botao_criar"),),
                  const SizedBox(height: 15),
                  ElevatedbuttonWidget(nome: "Voltar", metodo: _voltar, botaoKey: const Key("botao_voltar")),
            
            
                ],
              ),
          ),
          ),
        ),
      );
  }
}