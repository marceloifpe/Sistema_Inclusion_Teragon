import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_xy/pages/home.dart';
import 'package:flutter_application_xy/pages/login.dart';
import 'package:flutter_application_xy/services/database.dart';
import 'package:flutter_application_xy/services/shared_pref.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, mail, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && mail != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
            String id= randomAlphaNumeric(10);
            await SharedpreferenceHelper().saveUserName(namecontroller.text);
            await SharedpreferenceHelper().saveUserEmail(emailcontroller.text);
            // await SharedpreferenceHelper().saveUserImage('');
            await SharedpreferenceHelper().saveUserId(id);
            Map<String, dynamic> userInfoMap={
              "Nome": namecontroller.text,
              "Email": emailcontroller.text,
              "Id": id,
              // "Imagem": "https://firebasestorage.googleapis.com/gs://sistemainclusionteragonapp.appspot.com",
            };
             await DatabaseMethods().addUserDetails(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Registrado com Sucesso!",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'fraca-senha') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Senha muito Fraca, tente novamente",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        } else if (e.code == "email-está-em-uso") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Conta já Existe",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50.0, left: 30.0),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF81D4FA),
                Color(0xFF10B981),
                Color(0xFF10B921)
              ])),
              child: Text(
                "Criar Sua\nConta",
                style: TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0, bottom: 30.0),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome",
                      style: TextStyle(color: Color(0xFF81D4FA), fontSize: 23.0, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu nome';
                        }
                        return null;
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(hintText: "Digite Seu Nome Completo", prefixIcon: Icon(Icons.person_outline)),
                    ),
                    Text(
                      "Email",
                      style: TextStyle(color: Color(0xFF81D4FA), fontSize: 23.0, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu email';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(hintText: "Digite Seu Email", prefixIcon: Icon(Icons.mail_outline)),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      "Senha",
                      style: TextStyle(color: Color(0xFF81D4FA), fontSize: 23.0, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira sua Senha';
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: InputDecoration(hintText: "Digite Sua Senha", prefixIcon: Icon(Icons.password_outlined)),
                      obscureText: true,
                    ),
                    SizedBox(height: 60.0),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            mail = emailcontroller.text;
                            name = namecontroller.text;
                            password = passwordcontroller.text;
                          });
                          registration();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF81D4FA),
                            Color(0xFF10B981),
                            Color(0xFF10B921)
                          ]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Você já Possui Conta?",
                          style: TextStyle(color: Color(0xFF311937), fontSize: 17.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Entrar",
                            style: TextStyle(color: Color(0xFF10B921), fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
