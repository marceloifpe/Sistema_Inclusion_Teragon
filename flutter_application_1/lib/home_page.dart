import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao CRUD App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/create"); // Navega para o cadastro
              },
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login"); // Futuramente irá para a tela de login
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
