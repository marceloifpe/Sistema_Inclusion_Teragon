import 'package:flutter/material.dart';
import 'package:flutter_application_1/container_all.dart';
import 'package:flutter_application_1/field_form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/user_list.dart';
import 'package:flutter_application_1/user_provider.dart';

import 'user.dart';


class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  String title = "Create User";
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController(); // Novo campo para confirmação de senha

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    int? chave;
    if (userProvider.indexUser != null) {
      chave = userProvider.indexUser;
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
      controllerConfirmPassword.text = userProvider.userSelected!.password; // Preenche a confirmação
      setState(() {
        this.title = "Edit User";
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void save() {
      final isValidate = _key.currentState?.validate();
      if (isValidate == false) {
        return;
      }

      // Verifica se a senha e a confirmação de senha coincidem
      if (controllerPassword.text != controllerConfirmPassword.text) {
        // Exibe uma mensagem de erro se as senhas não coincidirem
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('As senhas não coincidem!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _key.currentState?.save();

      // Instancia da classe User um novo usuário
      User user = User(
        name: controllerName.text,
        email: controllerEmail.text,
        password: controllerPassword.text,
      );

      if (chave != null) {
        // Editar
        userProvider.users[chave] = user;
      } else {
        int usersLength = userProvider.users.length;

        // Salva um novo usuário
        userProvider.users.insert(usersLength, user);
      }

      // Navega de volta para a lista de usuários
      Navigator.popAndPushNamed(context, "/list");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child: TextButton(
              child: Text('UserList'),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/list");
              },
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            margin: EdgeInsets.all(8),
          ),
        ],
      ),
      body: ContainerAll(
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              children: [
                FieldForm(
                  label: 'Name',
                  isPassword: false,
                  controller: controllerName,
                  isEmail: false,
                ),
                FieldForm(
                  label: 'E-mail',
                  isPassword: false,
                  controller: controllerEmail,
                  isEmail: true,
                ),
                FieldForm(
                  label: 'Password',
                  isPassword: true,
                  controller: controllerPassword,
                  isEmail: false,
                ),
                FieldForm(
                  label: 'Confirm Password', // Campo para confirmar senha
                  isPassword: true,
                  controller: controllerConfirmPassword,
                  isEmail: false,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: save,
                    child: Text('Salvar'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}