class NoteModel {
  final int? noteId;
  final String noteTitle;
  final String noteContent;
  final String createdAt;

  NoteModel({
    this.noteId,
    required this.noteTitle,
    required this.noteContent,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(); // Define um valor padrão se não fornecido

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        noteId: json["noteId"],
        noteTitle: json["noteTitle"],
        noteContent: json["noteContent"],
        createdAt: json["createdAt"] ?? DateTime.now().toIso8601String(), // Valor padrão se nulo
      );

  Map<String, dynamic> toMap() => {
        "noteId": noteId,
        "noteTitle": noteTitle,
        "noteContent": noteContent,
        "createdAt": createdAt,
      };
}
