import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputLoginWidget extends StatelessWidget {
  
  final String hint;
  final bool obscure;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPhone;

  const InputLoginWidget({
    required this.hint, 
    required this.controller,
    this.obscure = false,
    this.type = TextInputType.text,
    this.validator,
    this.isPhone = false,
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {

    var phoneFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: { "#": RegExp(r'[0-9]') },
    );
    
    return TextFormField(
      controller: controller,
      // style: TextStyle(fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Color.fromARGB(255, 63, 63, 63)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none
        ),
        hintText: hint, 
      ),
      obscureText: obscure,
      keyboardType: type,
      validator: validator,
      inputFormatters: isPhone ? [phoneFormatter] : [],
    );
  }
}