import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authtentication/login.dart';
import 'package:flutter_application_1/JsonModels/users.dart';
import 'package:flutter_application_1/SQLite/sqlite.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  String? teaDegree = 'Grau 1'; // Valor inicial para o dropdown
  DateTime? selectedDate;

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93C5FD),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Título
                  const Text(
                    "Registrar Nova Conta",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Cor do título
                    ),
                  ),
                  const SizedBox(height: 30), // Espaçamento entre o título e o campo de nome

                  // Campo de nome
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Nome é obrigatório";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Nome",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

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
                        if (value!.isEmpty) {
                          return "Email é obrigatório";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Digite um email válido";
                        }
                        return null;
                      },
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
                        if (value!.isEmpty) {
                          return "Senha é obrigatória";
                        }
                        return null;
                      },
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Senha",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),

                  // Campo de confirmação de senha
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirmação de senha é obrigatória";
                        } else if (value != passwordController.text) {
                          return "Senhas não coincidem";
                        }
                        return null;
                      },
                      obscureText: !isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Confirmar Senha",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),

                  // Campo de data de nascimento
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: birthDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        border: InputBorder.none,
                        hintText: "Data de Nascimento",
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                  // Campo de grau de TEA (Dropdown)
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: teaDegree,
                      onChanged: (newValue) {
                        setState(() {
                          teaDegree = newValue;
                        });
                      },
                      items: <String>['Grau 1', 'Grau 2', 'Grau 3']
                          .map((degree) => DropdownMenuItem<String>(
                                value: degree,
                                child: Text(degree),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.accessibility),
                        border: InputBorder.none,
                        hintText: "Grau de TEA",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Grau de TEA é obrigatório";
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão de cadastro
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF10B921), // Cor do botão
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B921), // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final db = DatabaseHelper();
                          Users newUser = Users(
                            usrName: nameController.text,
                            usrEmail: emailController.text,
                            usrPassword: passwordController.text,
                            usrBirthDate: birthDateController.text,
                            usrTeaDegree: teaDegree!,
                          );

                          await db.signup(newUser);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Link para login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Já possui uma conta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Entrar",
                          style: TextStyle(color: Color(0xFF10B981)), // Cor do link de login
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
