import 'package:flutter/material.dart';
import 'package:flutter_application_xy/services/database.dart';
import 'package:flutter_application_xy/services/shared_pref.dart';
import 'package:flutter_application_xy/services/database.dart'; // Certifique-se de que esta importação está correta

class Booking extends StatefulWidget {
  final String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, email;

  getthedatafromsharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    email = await SharedpreferenceHelper().getUserEmail();
    setState(() {});
  }

  getontheload() async {
    await getthedatafromsharedpref();
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _recommendationController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF81D4FA),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30.0),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Inclusion Teragon,\nIncluindo Você no Mercado\n de Trabalho",
                style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset("imagens/teste2.png", fit: BoxFit.cover),
              ),
              SizedBox(height: 20.0),
              Text(
                widget.service,
                style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),

              // Nome do Evento
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _eventNameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Evento',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF93C5FD),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),

              // Escolha uma Data
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(color: Color(0xFF93C5FD), borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      "Escolha uma Data",
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month, color: Colors.white, size: 30.0),
                          SizedBox(width: 20.0),
                          Text(
                            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Escolha uma Hora
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(color: Color(0xFF93C5FD), borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      "Escolha uma Hora",
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time, color: Colors.white, size: 30.0),
                          SizedBox(width: 20.0),
                          Text(
                            "${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}",
                            style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Descrição
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF93C5FD),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 20.0),

              // Recomendação
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _recommendationController,
                  decoration: InputDecoration(
                    labelText: 'Recomendação',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF93C5FD),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 20.0),

              // Botão para agendar
              Center(
                child: GestureDetector(
                  onTap: () async {
                    String eventName = _eventNameController.text;
                    String description = _descriptionController.text;
                    String recommendation = _recommendationController.text;

                    // Montar o mapa de agendamento
                    Map<String, dynamic> userBookingMap = {
                      "Serviços": widget.service,
                      "Nome do Evento": eventName,
                      "Data": "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                      "Hora": _selectedTime.format(context).toString(),
                      "Descrição": description,
                      "Recomendação": recommendation,
                      "Nome": name,
                      "Email": email,
                    };

                    // Chamar o método para adicionar a reserva
                    await DatabaseMethods().addUserReserva(userBookingMap).then((value) {
                      // Mostrar mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Agendamento Realizado Com Sucesso!",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      );

                      // Limpar os campos
                      _eventNameController.clear();
                      _descriptionController.clear();
                      _recommendationController.clear();
                    });

                    // Exibir diálogo de agendamento
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Agendamento Realizado"),
                          content: Text("Seu evento foi agendado com sucesso."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF10B921),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Agendar Agora",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
