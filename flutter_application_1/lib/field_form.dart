import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FieldForm extends StatelessWidget {
  String label;
  bool isPassword;
  TextEditingController controller;
  bool? isForm = true;
  bool isEmail = false;
  TextEditingController? passwordController; // Controlador opcional para comparar senhas

  FieldForm({
    required this.label,
    required this.isPassword,
    required this.controller,
    this.isForm,
    required this.isEmail,
    this.passwordController, // Recebe o controlador da senha original
    super.key,
  });

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
        if (value == null || value.isEmpty) {
          return 'Este campo não pode ficar vazio';
        }

        if (this.isEmail) {
          if (!value.contains("@") || !value.contains(".")) {
            return 'Digite um Email Válido com domínio';
          }
        } else if (isPassword && passwordController != null) {
          if (value != passwordController!.text) {
            return 'As senhas não coincidem';
          }
        } else if (isPassword) {
          if (value.length < 8) {
            return 'A senha deve ter no mínimo 8 caracteres';
          }
          bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
          bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
          bool hasDigits = value.contains(RegExp(r'[0-9]'));
          bool hasSpecialCharacters = value.contains(RegExp(r'[!@#\$&*~]'));

          if (!hasUpperCase) {
            return 'A senha deve conter pelo menos uma letra maiúscula';
          }
          if (!hasLowerCase) {
            return 'A senha deve conter pelo menos uma letra minúscula';
          }
          if (!hasDigits) {
            return 'A senha deve conter pelo menos um número';
          }
          if (!hasSpecialCharacters) {
            return 'A senha deve conter pelo menos um caractere especial (!@#\$&*~)';
          }
        }

        return null;
      },
    );
  }
}