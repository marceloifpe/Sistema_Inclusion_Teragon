import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_xy/pages/login.dart';
import 'package:flutter_application_xy/services/database.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? bookingStream;

  // Função para carregar as reservas
  getOnTheLoad() async {
    bookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  // Widget para exibir todas as reservas
  Widget allBookings() {
    return StreamBuilder(
        stream: bookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.docs.isEmpty) {
            return Center(child: Text("Nenhuma reserva disponível"));
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return bookingCard(ds);
              },
            );
          }
        });
  }

  // Widget que exibe o cartão de reserva
  Widget bookingCard(DocumentSnapshot ds) {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF81D4FA),
              Color(0xFF10B981),
              Color(0xFF10B921)
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "imagens/agenda.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            bookingText("Inclusion Teragon: ", ds["Serviços"]),
            bookingText("Nome: ", ds["Nome"]),
            bookingText("Email: ", ds["Email"]),
            bookingText("Data: ", ds["Data"]),
            bookingText("Hora: ", ds["Hora"]),
            bookingText("Nome do Evento: ", ds["Nome do Evento"]),
            bookingText("Recomendação: ", ds["Recomendação"]),
            bookingText("Descrição: ", ds["Descrição"]),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza o texto "Feito"
              children: [
                GestureDetector(
                  onTap: () async {
                    await DatabaseMethods().DeleteReserva(ds.id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFdf711a),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Excluir",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Adicionando o botão Voltar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()), // Redireciona para a tela de login
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Voltar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  // Widget para formatar o texto da reserva
  Widget bookingText(String title, String value) {
    return Text(
      "$title$value",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 28.0, right: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Todas Reservas",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
