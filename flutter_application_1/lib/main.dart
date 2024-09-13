import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_form.dart';
import 'package:flutter_application_1/user_list.dart';
import 'package:flutter_application_1/user_provider.dart';
import 'package:flutter_application_1/home_page.dart'; // Importa a nova tela inicial
import 'package:flutter_application_1/user_home_page.dart'; // Importa a nova tela inicial do usuário
import 'package:flutter_application_1/login_page.dart'; // Importa a tela de login
import 'user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        title: 'CRUD APP',
        home: HomePage(), // Define HomePage como tela inicial
        routes: {
          "/create": (_) => UserForm(),
          "/list": (_) => UserList(),
          "/login": (_) => LoginPage(), // Atualiza para a tela de login
          "/view": (_) => UserView(),
          "/user_home": (_) => UserHomePage(userName: 'Usuário'), // Atualiza para a tela inicial do usuário
        },
      ),
    );
  }
}
