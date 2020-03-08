import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/chats/message_stream.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.friendUID});

  final msgClear = TextEditingController();
  final String friendUID;
  Firestore _firestore = Firestore.instance;

  String msgText;

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
                        controller: msgClear,
                        onChanged: (val) {
                          msgText = val;
                        },
                      )
                  ),
                  FlatButton(
                    child: Text('Send'),

                    onPressed: () {
                      msgClear.clear();

                      _firestore.collection('messages').document(
                          current_user_uid).collection(friendUID).add({
                        'text': msgText,
                        'time': DateTime.now(),
                        'to': friendUID,
                        'from': current_user_uid,
                      });

                      _firestore.collection('messages')
                          .document(friendUID)
                          .collection(current_user_uid)
                          .add({
                        'text': msgText,
                        'time': DateTime.now(),
                        'from': friendUID,
                        'to': current_user_uid,
                      });
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
