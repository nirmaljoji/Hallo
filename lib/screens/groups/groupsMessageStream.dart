import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/services/database.dart';

class GroupMessages extends StatelessWidget {

  String groupUID;
  Firestore _firestore = Firestore.instance;
  GroupMessages({this.groupUID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .document(current_user_uid)
            .collection('groups_chat')
            .document(groupUID)
            .collection('Chats')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chat = snapshot.data.documents;
            List<MessageBubble> messages = [];
            for (var msg in chat) {
              final msgText = msg.data['text'];
              //final msgTo = msg.data['to'];
              final msgFrom = msg.data['from'];
              final msgtime = msg.data['time'];

              final bub = MessageBubble(
                text: msgText,
                time: msgtime,
                isMe: msgFrom == current_user_uid,
                //to: msgTo,
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
  final String text, from;
  final bool isMe;
  final Timestamp time;
  Color c;
  MessageBubble({this.text, this.isMe, this.time, this.from});

  String gettime() {
    try {
      return time.toDate().toIso8601String().substring(11, 16);
    }
    catch (e) {
      print(e);
    }
    return '0';
  }


  @override
  Widget build(BuildContext context) {
    Widget _getName(String from) {
      return StreamBuilder(
          stream: DatabaseService(uid: from).userData,
          builder: (context, ss) {
            if (!ss.hasData) {
              return Text('x');
            }
            UserData userData = ss.data;
            return Text(
              '${userData.name}',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black
              ),
            );
          }
      );
    }

    c = isMe ? Colors.blue : Colors.black12;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[

          _getName(from),

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
          SizedBox(
            height: 5,
          ),
          Text(
            gettime(),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

