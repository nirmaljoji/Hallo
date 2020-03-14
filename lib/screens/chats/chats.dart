import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/fab_circular_menu.dart';
import 'package:hallo/screens/chats/select_friend.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {

  @override
  Widget build(BuildContext context) {
    //this returns Scaffold only

    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: FabCircularMenu(
        fabMargin: EdgeInsets.fromLTRB(
            screenWidth / 1.22, screenHeight / 1.25, 5, 5),
        ringColor: Theme
            .of(context)
            .splashColor,
        fabColor: Theme
            .of(context)
            .splashColor,
        fabOpenIcon: Icon(Icons.add),
        ringDiameter: screenWidth,
        options: <Widget>[
          IconButton(
              icon: Icon(
                Icons.face,
              ),

              onPressed: () {
                print('Pressed!');
              }),
          IconButton(
              icon: Icon(
                  Icons.group_add
              ),
              onPressed: () {
                print('Pressed!');
              }),
          IconButton(
              icon: Icon(
                  Icons.send
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SelectFriend()));
              }),
        ],
        //child: ChatStream(),
        child: Text(''),
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
    );
  }
}


