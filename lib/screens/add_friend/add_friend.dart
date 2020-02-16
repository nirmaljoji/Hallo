import 'package:flutter/material.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';

class Add_friend extends StatefulWidget {

  String id = '/add_friend';

  @override
  _Add_friendState createState() => _Add_friendState();
}

class _Add_friendState extends State<Add_friend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Nav_menu(),
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Add Friend"
        ),
      ),
      body: Text("This is Add Friend Page"),
    );
  }
}
