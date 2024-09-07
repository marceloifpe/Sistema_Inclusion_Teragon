import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_form.dart';
import 'package:flutter_application_1/user_list.dart';
import 'package:flutter_application_1/user_provider.dart';

import 'user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        title: 'CRUD APP',
        home: UserForm(),
        routes: {
          "/create": (_) => UserForm(),
          "/list": (_) => UserList(),
          "/view": (_) => UserView(),
        },
      ),
    );
  }
}
