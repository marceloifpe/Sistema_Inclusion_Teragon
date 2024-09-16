// lib/JsonModels/users.dart
class Users {
  final int? usrId;
  final String usrName;
  final String usrEmail;
  final String usrPassword;
  final String usrBirthDate; // Novo campo
  final String usrTeaDegree; // Novo campo

  Users({
    this.usrId,
    required this.usrName,
    required this.usrEmail,
    required this.usrPassword,
    required this.usrBirthDate,
    required this.usrTeaDegree,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usrEmail: json["usrEmail"],
        usrPassword: json["usrPassword"],
        usrBirthDate: json["usrBirthDate"], // Adicionando o campo
        usrTeaDegree: json["usrTeaDegree"], // Adicionando o campo
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usrEmail": usrEmail,
        "usrPassword": usrPassword,
        "usrBirthDate": usrBirthDate, // Adicionando o campo
        "usrTeaDegree": usrTeaDegree, // Adicionando o campo
      };
}
