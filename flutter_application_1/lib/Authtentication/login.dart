import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authtentication/signup.dart';
import 'package:flutter_application_1/JsonModels/users.dart';
import 'package:flutter_application_1/SQLite/sqlite.dart';
import 'package:flutter_application_1/Views/notes.dart'; // Verifique o caminho para Notes.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93C5FD), // Cor de fundo
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Imagem circular
                  CircleAvatar(
                    radius: 105,
                    backgroundColor: Colors.white, // Cor de fundo da imagem
                    child: ClipOval(
                      child: Image.asset(
                        "lib/assets/login.png", // Verifique o caminho da imagem
                        width: 210,
                        height: 210,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Título
                  const Text(
                    "Inclusion Teragon",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Cor do título
                    ),
                  ),
                  const SizedBox(height: 30), // Espaçamento entre o título e o campo de email
                  // Campo de email
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email é obrigatório";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Digite um email válido";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  // Campo de senha
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Senha é obrigatória";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Senha",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Botão de login
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF10B921), // Cor do botão
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final db = DatabaseHelper();
                          bool isAuthenticated = await db.login(
                            Users(
                              usrEmail: emailController.text,
                              usrPassword: passwordController.text,
                              usrName: '', // Campo não utilizado
                              usrBirthDate: '', // Campos não utilizados
                              usrTeaDegree: '', // Campos não utilizados
                            ),
                          );

                          if (isAuthenticated) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Notes()), // Navegação para Notes
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Credenciais inválidas"),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Link para cadastro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Não tem uma conta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: const Text(
                          "Cadastrar",
                          style: TextStyle(color: Color(0xFF10B981)), // Cor do link de cadastro
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
