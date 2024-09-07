import 'package:flutter/material.dart';
import 'package:flutter_application_1/field_form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/user_list.dart';
import 'package:flutter_application_1/user_provider.dart';

import 'user.dart';



class UserView extends StatelessWidget {
  UserView({super.key});

  String title = "Show User";
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    int? chave;
    if (userProvider.indexUser != null) {
      chave = userProvider.indexUser;
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
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
                borderRadius: BorderRadius.all(Radius.circular(8))),
            margin: EdgeInsets.all(8),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FieldForm(
              label: 'Name',
              isPassword: false,
              controller: controllerName,
              isForm: false,
            ),
            FieldForm(
              label: 'E-mail',
              isPassword: false,
              controller: controllerEmail,
              isForm: false,
            ),
            FieldForm(
              label: 'Password',
              isPassword: false,
              controller: controllerPassword,
              isForm: false,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/create");
                },
                child: Text('Edit'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  userProvider.indexUser = null;
                  userProvider.users.removeAt(chave!);
                  Navigator.popAndPushNamed(context, "/create");
                },
                child: Text('Delete'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}