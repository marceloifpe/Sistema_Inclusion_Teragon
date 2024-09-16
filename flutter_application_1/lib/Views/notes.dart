import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authtentication/login.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/JsonModels/note_model.dart';
import 'package:flutter_application_1/SQLite/sqlite.dart';
import 'package:flutter_application_1/Views/create_note.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHelper();
    notes = handler.getNotes();
    handler.initDB().whenComplete(() {
      setState(() {
        notes = handler.getNotes();
      });
    });
  }

  Future<List<NoteModel>> searchNote() {
    return handler.searchNotes(keywordController.text);
  }

  Future<void> _refresh() async {
    setState(() {
      notes = handler.getNotes();
    });
  }

  void _logout() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.note, size: 100, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Notas App',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sair'),
                onTap: _logout,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateNote()))
              .then((value) {
            if (value ?? false) {
              _refresh();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: keywordController,
                  onChanged: (value) {
                    setState(() {
                      notes = value.isNotEmpty ? searchNote() : handler.getNotes();
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: "Search",
                  ),
                ),
              ),
              SizedBox(height: 10), // Espaçamento para evitar o overflow
              FutureBuilder<List<NoteModel>>(
                future: notes,
                builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(child: Text("No data"));
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    final items = snapshot.data ?? <NoteModel>[];
                    return ListView.builder(
                      shrinkWrap: true, // Ajusta o tamanho do ListView ao tamanho do conteúdo
                      physics: const NeverScrollableScrollPhysics(), // Desativa o rolamento do ListView
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final note = items[index];
                        return ListTile(
                          subtitle: Text(DateFormat("yMd").format(DateTime.parse(note.createdAt))),
                          title: Text(note.noteTitle),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              handler.deleteNote(note.noteId!).whenComplete(() {
                                _refresh();
                              });
                            },
                          ),
                          onTap: () {
                            titleController.text = note.noteTitle;
                            contentController.text = note.noteContent;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Update note"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          labelText: "Title",
                                        ),
                                      ),
                                      TextFormField(
                                        controller: contentController,
                                        decoration: const InputDecoration(
                                          labelText: "Content",
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        handler.updateNote(
                                          titleController.text,
                                          contentController.text,
                                          note.noteId!,
                                        ).whenComplete(() {
                                          _refresh();
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text("Update"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
