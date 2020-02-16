import 'package:flutter/material.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';

class Groups extends StatefulWidget {

  String id = '/groups';

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
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
      backgroundColor: Colors.grey[800],
      drawer: Nav_menu(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
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
