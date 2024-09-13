import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_form.dart';
import 'package:flutter_application_1/user_list.dart';
import 'package:flutter_application_1/user_provider.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/login_page.dart'; // Importa a nova tela de login
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
        home: HomePage(),
        routes: {
          "/create": (_) => UserForm(),
          "/list": (_) => UserList(),
          "/login": (_) => LoginPage(), // Define a nova tela de login
          "/view": (_) => UserView(),
        },
      ),
    );
  }
}
