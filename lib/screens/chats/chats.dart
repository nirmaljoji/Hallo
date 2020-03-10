import 'package:flutter/material.dart';
import 'package:hallo/components/fab_circular_menu.dart';
import 'package:hallo/screens/add_friend/initiate_chat.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {

  @override
  Widget build(BuildContext context) {
    //this returns Scaffold only


    void _initiateChat() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: InitiateChat(),
              //Text('New message to: '),

            );
          }
      );
    }


    /*

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme
            .of(context)
            .splashColor,
        onPressed: () {
          _initiateChat();

        },
      ),

    */
    return Scaffold(
      body: FabCircularMenu(
        child: Text('add chats list here'),
        options: <Widget>[
          IconButton(
            icon: Icon(Icons.face),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {

            },
          ),
        ],
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


