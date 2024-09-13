import 'package:flutter/material.dart';
import 'package:flutter_application_1/container_all.dart';

class UserHomePage extends StatelessWidget {
  final String userName;

  UserHomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $userName!'),
      ),
      body: ContainerAll(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tela Inicial do Usuário', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Text('Bem-vindo de volta, $userName!', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
