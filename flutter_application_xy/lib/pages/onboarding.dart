import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2b1615),
      body: Container(
        margin: EdgeInsets.only(top: 120.0),
        child: Column(
          children: [
            Image.asset("imagens/login.png"),
            SizedBox(height: 50.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFdf711a),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Get App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
