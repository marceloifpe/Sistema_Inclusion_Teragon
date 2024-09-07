import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'user.dart';
import 'user_provider.dart';


class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    List<User> users = userProvider.users;

    int usersLength = users.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        leading: BackButton(
          onPressed: () {
            userProvider.indexUser = null;
            Navigator.popAndPushNamed(context, "/create");
          },
        ),
      ),
      body: ListView.builder(
          itemCount: usersLength,
          itemBuilder: (BuildContext contextBuilder, indexBuilder) => Container(
                child: ListTile(
                  title: Text(users[indexBuilder].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            userProvider.userSelected = users[indexBuilder];
                            userProvider.indexUser = indexBuilder;
                            Navigator.popAndPushNamed(context, "/create");
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            userProvider.userSelected = users[indexBuilder];
                            userProvider.indexUser = indexBuilder;
                            Navigator.popAndPushNamed(context, "/view");
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {
                            userProvider.indexUser = null;
                            userProvider.users.removeAt(indexBuilder); // CORRIGIDO
                            Navigator.popAndPushNamed(context, "/create");
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.4))),
              )),
    );
  }
}
