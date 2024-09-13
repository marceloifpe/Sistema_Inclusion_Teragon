import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FieldForm extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final bool? isForm;
  final bool isEmail;
  final TextEditingController? passwordController; // Controlador opcional para comparar senhas

  FieldForm({
    required this.label,
    required this.isPassword,
    required this.controller,
    this.isForm = true,
    required this.isEmail,
    this.passwordController, // Recebe o controlador da senha original para comparar
    super.key,
  });

  @override
  _FieldFormState createState() => _FieldFormState();
}

class _FieldFormState extends State<FieldForm> {
  bool _obscureText = true; // Controle de visibilidade do texto da senha

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isForm,
      obscureText: widget.isPassword ? _obscureText : false, // Alterna a visibilidade da senha
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Alterna entre mostrar/esconder a senha
                  });
                },
              )
            : null, // Adiciona o botão de visibilidade apenas para campos de senha
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo não pode ficar vazio';
        }

        // Validação de e-mail
        if (widget.isEmail) {
          if (!value.contains("@") || !value.contains(".")) {
            return 'Digite um Email Válido com domínio';
          }
        }

        // Validação de confirmação de senha
        if (widget.isPassword && widget.passwordController != null) {
          if (value != widget.passwordController!.text) {
            return 'As senhas não coincidem';
          }
        }

        // Validação de criação de senha
        if (widget.isPassword && widget.passwordController == null) {
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