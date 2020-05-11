import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/components/fab_circular_menu.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/chats/chat_page.dart';
import 'package:hallo/screens/chats/select_friend.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/database.dart';


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {
  Firestore _firestore = Firestore.instance;

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

    Widget func() {
      return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('user_profiles')
            .document('$current_user_uid')
            .collection('friends')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Text('nothing here ra dumma'),
            );
          }
          else {
            final alreadyChatPeople = snapshot.data.documents;
            List<ChattedPeople> chattedPeopleList = [];
            for (var person in alreadyChatPeople) {
              final String uid = person.data['user_id'];
              final bool flag = person.data['chat'];
              final box = ChattedPeople(
                friendUID: uid,
              );
              if (flag) {
                chattedPeopleList.add(box);
              }
            }
            return ListView(
              children: chattedPeopleList,
            );
          }
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: func(),
          ),
          FabCircularMenu(
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
                        MaterialPageRoute(
                            builder: (context) => SelectFriend()));
                  }),
            ],
            //child: ChatStream(),
            child: Text(''),
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

class ChattedPeople extends StatelessWidget {

  final String friendUID;

  ChattedPeople({this.friendUID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: friendUID).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else {
          UserData userData = snapshot.data;
//          print('${userData.imageUrl} is image url');
//          print('${userData.name} is name');
          return ChatButton(
              friendName: userData.name,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(friendUID: friendUID,
                          fname: userData.name,)));
              },
              imageURL: userData.imageUrl
          );
        }
      },
    );
  }
}


