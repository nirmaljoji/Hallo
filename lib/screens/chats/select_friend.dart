import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/initiate_chat.dart';

class SelectFriend extends StatefulWidget {
  @override
  _SelectFriendState createState() => _SelectFriendState();
}

class _SelectFriendState extends State<SelectFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 4,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child:
            InitiateChat(),

        //Text('New message to: '),
      ),
    );
  }
}
