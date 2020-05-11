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
            .collection('${friendUID}').orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chat = snapshot.data.documents;
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
              height: (MediaQuery
                  .of(context)
                  .size
                  .height) / 1.3,
              child: ListView(
                  reverse: true,
                  children: messages != null ? messages : defaultText
              ),
            );
          }
          return Text('no messages haha');
        }
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text, to, from;
  final bool isMe;
  final Timestamp time;
  Color c;

  MessageBubble({this.text, this.isMe, this.time, this.to, this.from});

  String gettime() {
    try {
      return time.toDate().toIso8601String();
    }
    catch (e) {
      print(e);
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    print('$isMe is isMe');
    c = isMe ? Colors.blue : Colors.black12;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          //ADD FOR GROUPS NOT NECESSARY HERE
          /*
          Text(
            from,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          */
          Text(
            gettime(),
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
                  fontSize: 18.0, //18.0
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

