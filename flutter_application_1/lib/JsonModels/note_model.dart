class NoteModel {
  int? noteId;
  String noteTitle;
  String noteContent;
  String createdAt;
  String? eventDate;
  String? eventTime;

  NoteModel({
    this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.createdAt,
    this.eventDate,
    this.eventTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'noteTitle': noteTitle,
      'noteContent': noteContent,
      'createdAt': createdAt,
      'eventDate': eventDate,
      'eventTime': eventTime,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      noteId: map['noteId'],
      noteTitle: map['noteTitle'],
      noteContent: map['noteContent'],
      createdAt: map['createdAt'],
      eventDate: map['eventDate'],
      eventTime: map['eventTime'],
    );
  }
}
