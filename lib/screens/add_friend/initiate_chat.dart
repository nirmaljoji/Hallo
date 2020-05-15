import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/chats/chat_page.dart';
import 'package:hallo/services/database.dart';

class InitiateChat extends StatelessWidget {
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('user_profiles')
            .document('$current_user_uid')
            .collection('friends')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          }
          else {
            final friends = snapshot.data.documents;
            List<FriendDetails> list = [];
            for (var x in friends) {
              final String uid = x.data['user_id'];

              final xyz = FriendDetails(
                friendUID: uid,
              );
              list.add(xyz);
            }
            return ListView(
              children: list,
            );
          }
        });
  }
}

class FriendDetails extends StatelessWidget {
  final String friendUID;

  FriendDetails({this.friendUID});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: DatabaseService(uid: friendUID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return ChatButton(
              friendName: userData.name,
              imageURL: userData.imageUrl,
              bDay: 0,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(
                          friendUID: friendUID,
                          fname: userData.name,
                        )
                ));
              },

            );
          }
          return Text('');
        });
  }
}

/*
Container(
              width: screenWidth,
              child: Material(
                borderRadius: BorderRadius.circular(60.0),
                elevation: 2.0,
                color: Colors.white70,
                child: MaterialButton(
                  color: Theme
                      .of(context)
                      .canvasColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ChatPage(
                              friendUID: friendUID, fname: userData.name,)
                    ));
                  },
                  height: screenHeight/10,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(4.0),
                    leading: userData.imageUrl != null
                        ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme
                          .of(context)
                          .backgroundColor,
                      backgroundImage: AssetImage('images/loading.png'),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180,
                          height: 180,
                          child: userData.imageUrl != null
                              ? Image.network(
                            userData.imageUrl,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            color: Theme
                                .of(context)
                                .backgroundColor,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage('images/loading.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        : CircleAvatar(
                      //backgroundImage: AssetImage('images/user1.png'),
                      backgroundColor: Theme
                          .of(context)
                          .backgroundColor,
                      radius: 32.0,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userData.name,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
//                      Text(
//                        'Hey! Whats up?',
//                        style: Theme.of(context).textTheme.body2,
//                      ),
                      ],
                    ),
                  ),
                ),
              ),
            )
 */