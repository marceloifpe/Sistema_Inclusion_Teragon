import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FieldForm extends StatelessWidget {
  String label;
  bool isPassword;
  TextEditingController controller;
  bool? isForm = true;
  bool isEmail = false;
  FieldForm(
      {required this.label,
      required this.isPassword,
      required this.controller,
      this.isForm,
      required this.isEmail,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.isForm,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
      ),
      validator: (value) {
        if (value!.length < 5){
          return 'Digite Pelo Menos 5 Caracteres';
        }
        if (this.isEmail && !value.contains("@")) {
          return 'Digite um Email Válido';
        }
      },
    );
  }
}
