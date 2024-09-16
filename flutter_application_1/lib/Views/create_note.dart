import 'package:flutter/material.dart';
import 'package:flutter_application_1/JsonModels/note_model.dart';
import 'package:flutter_application_1/SQLite/sqlite.dart';
import 'package:intl/intl.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final db = DatabaseHelper();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _saveNote() {
    if (formKey.currentState!.validate()) {
      final eventDate = selectedDate != null
          ? DateFormat('dd/MM/yyyy').format(selectedDate!)
          : null;
      final eventTime = selectedTime != null
          ? selectedTime!.format(context)
          : null;

      db.createNote(NoteModel(
        noteTitle: titleController.text,
        noteContent: contentController.text,
        createdAt: DateTime.now().toIso8601String(),
        eventDate: eventDate,
        eventTime: eventTime,
      )).whenComplete(() {
        Navigator.of(context).pop(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Agendamento"),
        actions: [
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Nome do Evento",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: contentController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Content is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Descrição",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(selectedDate == null
                          ? 'Selecione uma Data'
                          : 'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: _selectDate,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(selectedTime == null
                          ? 'Selecione um Horário'
                          : 'Hora: ${selectedTime!.format(context)}'),
                      trailing: Icon(Icons.access_time),
                      onTap: _selectTime,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
