import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/JsonModels/note_model.dart';
import 'package:flutter_application_1/JsonModels/users.dart';

class DatabaseHelper {
  final databaseName = "app_database.db"; // Nome do banco de dados

  // Criação da tabela de notas
  String noteTable = """
    CREATE TABLE notes (
      noteId INTEGER PRIMARY KEY AUTOINCREMENT,
      noteTitle TEXT NOT NULL,
      noteContent TEXT NOT NULL,
      createdAt TEXT DEFAULT CURRENT_TIMESTAMP
    )
  """;

  // Criação da tabela de usuários
  String usersTable = """
    CREATE TABLE users (
      usrId INTEGER PRIMARY KEY AUTOINCREMENT,
      usrEmail TEXT UNIQUE NOT NULL,
      usrPassword TEXT NOT NULL,
      usrBirthDate TEXT,
      usrTeaDegree TEXT
    )
  """;

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(
      path,
      version: 2, // Atualize a versão para refletir a mudança
      onCreate: (db, version) async {
        await db.execute(usersTable);
        await db.execute(noteTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Verifica se a coluna já existe antes de tentar adicioná-la
          var result = await db.rawQuery('PRAGMA table_info(users)');
          bool columnExists = result.any((column) => column['name'] == 'usrName');
          if (!columnExists) {
            await db.execute('ALTER TABLE users ADD COLUMN usrName TEXT');
          }
        }
      },
    );
  }

  // Método de Login utilizando usrEmail e usrPassword
  Future<bool> login(Users user) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "SELECT * FROM users WHERE usrEmail = ? AND usrPassword = ?",
        [user.usrEmail, user.usrPassword]);

    return result.isNotEmpty;
  }

  // Método de cadastro, agora incluindo os novos campos
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert('users', user.toMap());
  }

  // Método de busca por notas
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db.rawQuery(
        "SELECT * FROM notes WHERE noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  // Métodos CRUD para notas

  // Criar nota
  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  // Buscar todas as notas
  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  // Deletar nota
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  // Atualizar nota
  Future<int> updateNote(String title, String content, int noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'UPDATE notes SET noteTitle = ?, noteContent = ? WHERE noteId = ?',
        [title, content, noteId]);
  }
}
