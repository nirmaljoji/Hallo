import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/screens/chats/message_stream.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.friendUID});

  final String friendUID;
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            friendUID
        ),
        backgroundColor: Theme
            .of(context)
            .accentColor,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            MessagesStream(
              friendUID: friendUID,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: TextField(

                        onChanged: (val) {

                        },
                      )
                  ),
                  FlatButton(
                    child: Text('Send'),

                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
