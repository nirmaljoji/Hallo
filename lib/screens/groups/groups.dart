import 'package:flutter/material.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Nav_menu(),
      appBar: AppBar(
        title: Text(
          "Groups"
        ),
      ),
      body:Container(
        child: Text(
        "this is groups page"
      ),
    )
    );
  }
}
