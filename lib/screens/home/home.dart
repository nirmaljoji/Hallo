
import 'package:flutter/material.dart';
import 'package:hallo/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Hallo",
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