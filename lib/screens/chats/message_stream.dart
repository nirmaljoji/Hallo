import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';

class MessagesStream extends StatelessWidget {
  final String friendUID;

  MessagesStream({this.friendUID});

  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    print('current is $current_user_uid and friend is $friendUID');
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .document(current_user_uid)
            .collection('${friendUID}')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chat = snapshot.data.documents.reversed;
            List<MessageBubble> messages = [];
            for (var msg in chat) {
              final msgText = msg.data['text'];
              final msgTo = msg.data['to'];
              final msgFrom = msg.data['from'];
              final msgtime = msg.data['time'];

              final bub = MessageBubble(
                text: msgText,
                time: msgtime,
                isMe: msgFrom == current_user_uid,
                to: msgTo,
                from: msgFrom,
              );
              messages.add(bub);
            }
            List defaultText = [Text('Initiate chat')];
            return Container(
              height: 700,
              child: ListView(
                  reverse: true,
                  children: messages != null ? messages : defaultText
              ),
            );
          }
          return Text('_');
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String text, to, from;
  final bool isMe;
  final Timestamp time;
  Color c;

  MessageBubble({this.text, this.isMe, this.time, this.to, this.from});

  @override
  Widget build(BuildContext context) {
    c = isMe ? Colors.blue : Colors.black12;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            color: c,
            elevation: 5.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              //logout
              _auth.signOut();
              print('logged out');

              //messageStream();

              Navigator.pop(context);
            },
          ),
        ],
        title: Text('Zoey Chats'),
        backgroundColor: Colors.brown.shade500,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.brown.shade200, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextControler,
                      onChanged: (value){
                        //user input
                        msgText=value;
                      },
                      decoration:InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      //print(loggedInUser);
                      //send
                      _firestore.collection('messages').add({
                        'text':msgText,
                        'sender': loggedInUser.email,
                      });

                      msgTextControler.clear();

                      print('sent msg and sender to fb');
                    },
                    child: Text('send'),
                  )
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
 */