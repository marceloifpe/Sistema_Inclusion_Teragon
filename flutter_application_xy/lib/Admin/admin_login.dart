import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_xy/Admin/reserva_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller= new TextEditingController();
  TextEditingController userpasswordcontroller= new TextEditingController();
  @override
  Widget build(BuildContext context){
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
                "Admin\nPainel",
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
               
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      "Username",
                      style: TextStyle(color: Color(0xFF81D4FA), fontSize: 23.0, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      
                      controller: usernamecontroller,
                      decoration: InputDecoration(hintText: "Digite Seu Nome", prefixIcon: Icon(Icons.mail_outline)),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      "Senha",
                      style: TextStyle(color: Color(0xFF81D4FA), fontSize: 23.0, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      
                      controller: userpasswordcontroller,
                      decoration: InputDecoration(hintText: "Digite Sua Senha", prefixIcon: Icon(Icons.password_outlined)),
                      obscureText: true,
                    ),
                    SizedBox(height: 60.0),
                    GestureDetector(
                      onTap: () {
                      loginAdmin();
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
                            "Entrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Sua identificação não está Correta !",
            style: TextStyle(fontSize: 20.0),
          )));
        } else if (result.data()['password'] !=
            userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Sua Senha não está Correta !",
            style: TextStyle(fontSize: 20.0),
          )));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BookingAdmin()));
        }
      });
    });
  }
}