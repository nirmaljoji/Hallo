import 'package:flutter/material.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/auth.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Nav_menu(),
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Hallo Chats",
          style: TextStyle(
            color: Colors.amberAccent[400],
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),),
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.amberAccent[100],
                ),)
          )
        ],
      ),
    );
  }
}
