import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/components/fab_circular_menu.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/chats/chat_page.dart';
import 'package:hallo/screens/chats/select_friend.dart';
import 'package:hallo/screens/groups/create_group.dart';
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
              child: Text('Loading...'),
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
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => CreateGroup()));

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
        ),
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ChatSearch(true),
              );
            },
          )
        ]
      ),
      //Text("user name = $current_user_uid"),
    );
  }
}

class ChattedPeople extends StatelessWidget {

  final String friendUID;
  final String query;

  ChattedPeople({this.friendUID, this.query});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: friendUID).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else if(query == null || query == ''){
          UserData userData = snapshot.data;
//          print('${userData.imageUrl} is image url');
//          print('${userData.name} is name');
          return ChatButton(
              group: true,
              guid: null,
              friendName: userData.name,
              fuid: userData.uid,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(friendUID: friendUID,
                          fname: userData.name,)));
              },
              imageURL: userData.imageUrl
          );
        } else{
          UserData userData = snapshot.data;
          if(userData.name.toLowerCase().contains(query.toLowerCase())){
            return ChatButton(
                group: false,
                guid: null,
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
          } else {
            return Container();
          }
        }
      },
    );
  }
}

class ChatSearch extends SearchDelegate<ChattedPeople>{

  Firestore _firestore = Firestore.instance;
  final bool chatChk;

  ChatSearch(this.chatChk);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('user_profiles')
          .document('$current_user_uid')
          .collection('friends')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Text('                GROUPS                 '),
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
              query: query,
            );
            if (flag) {
              chattedPeopleList.add(box);
            }
            else if(!chatChk){
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('user_profiles')
          .document('$current_user_uid')
          .collection('friends')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(child: Text('Loading..')),
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
              query: query,
            );
            if (flag) {
              chattedPeopleList.add(box);
            }
            else if(!chatChk){
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
}
