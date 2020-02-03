import 'package:flutter/material.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/models/uid.dart';



class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}



class _ChatsState extends State<Chats> {

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(


        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          backgroundColor: Colors.amber,
        onPressed: (){
      setState(() {

      });

    },
        ),

      drawer: Nav_menu(),
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Chats",
          style: TextStyle(

            fontWeight: FontWeight.bold,

          ),),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 4,

      ),
      body: Text("user name = $current_user_uid"),
    );
  }
}
