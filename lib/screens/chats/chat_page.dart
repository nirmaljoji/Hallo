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
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: ListView(
            children: <Widget>[
              MessagesStream(
                friendUID: friendUID,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(7.0, 0, 5.0, 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: msgClear,
                          onChanged: (val) {
                            msgText = val;
                          },
                          autocorrect: true,
                          decoration: InputDecoration(
                            fillColor: Theme
                                .of(context)
                                .canvasColor,
                            filled: true,
                            contentPadding: EdgeInsets.all(12.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(color: Theme
                                  .of(context)
                                  .canvasColor, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(color: Theme
                                  .of(context)
                                  .focusColor, width: 2.0),
                            ),
                            hintText: ' Type message',
                            //hint
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .body2,
                          ),
                        )
                    ),
                    Container(
                      width: 70.0,
                      height: 70.0,
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Icon(
                          Icons.send,
                          color: Theme
                              .of(context)
                              .canvasColor,
                        ),
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
                            'from': current_user_uid,
                            'to': friendUID,
                          });
                        },
                        color: Theme
                            .of(context)
                            .splashColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
