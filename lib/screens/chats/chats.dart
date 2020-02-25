import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/show_friends.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Theme
            .of(context)
            .splashColor,
        onPressed: () {
          setState(() {

          });
        },
      ),

      drawer: Nav_menu(),
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(
        title: Text("Chats",
          style: Theme
              .of(context)
              .textTheme
              .title,
        ),
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        elevation: 4,
      ),
      //Text("user name = $current_user_uid"),
      body: ListStream(),
    );
  }
}


