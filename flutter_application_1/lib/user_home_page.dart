import 'package:flutter/material.dart';
import 'package:flutter_application_1/container_all.dart';
import 'package:flutter_application_1/user_form.dart'; // Importe a tela de edição de perfil
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/user_form.dart'; // Importe a tela de login

class UserHomePage extends StatelessWidget {
  final String userName;

  UserHomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $userName!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                // Navega para a tela de edição de perfil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserForm()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                // Navega de volta para a tela de login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
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
