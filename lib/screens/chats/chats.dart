import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/auth.dart';


Firestore _firestore = Firestore.instance;


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {


  final AuthService _auth = AuthService();

  void getConversationList() async {
    print('list of all converstions');
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var convo in snapshot.documents) {
        print(convo.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.amber,
        onPressed: () {
          getConversationList();
          setState(() {

          });
        },
      ),

      drawer: Nav_menu(),
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Chats",
          style: TextStyle(

            fontWeight: FontWeight.bold,

          ),),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 4,

      ),
      //Text("user name = $current_user_uid"),
      body: ListStream(),
    );
  }
}

class ListStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('user_profiles').document(
            '$current_user_uid').collection('friends').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('no'),
            );
          }
          else {
            print('in else part');
            final listElements = snapshot.data.documents;
            List<UserDeets> conversationList = [];
            for (var user in listElements) {
              final uid = user.data['uid'];
              print('herre');

              final z = UserDeets(
                friendUID: uid,
              );

              conversationList.add(z);
            }
            return ListView(
              children: conversationList,
            );
          }
        }
    );
  }
}

class UserDeets extends StatelessWidget {

  final String friendUID;
  String name = "";

  UserDeets({this.friendUID});

  void getFriendsName() async {
    await for (var snapshot in _firestore.collection('user_profiles').document(
        '$friendUID').snapshots()) {
      name = snapshot.data['user_name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: <Widget>[
            ChatButton(
              friendName: name,
              onPressed: () {
                print('hey it worksss');
              },
            ),
          ]
      ),
    );
  }
}



