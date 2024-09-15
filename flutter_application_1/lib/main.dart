import 'package:flutter/material.dart';
// import 'package:flutter_application_1/user_form.dart';
// import 'package:flutter_application_1/user_list.dart';
// import 'package:flutter_application_1/user_provider.dart';
// import 'package:flutter_application_1/home_page.dart'; // Importa a nova tela inicial
// import 'package:flutter_application_1/user_home_page.dart'; // Importa a nova tela inicial do usuário
// import 'package:flutter_application_1/login_page.dart'; // Importa a tela de login
// import 'user_view.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Authtentication/login.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}