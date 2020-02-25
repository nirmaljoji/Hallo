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
          backgroundColor: Theme
              .of(context)
              .splashColor,

          onPressed: (){
            setState(() {

            });

          },
        ),
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
      drawer: Nav_menu(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .accentColor,
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
