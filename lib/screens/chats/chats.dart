import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              final x = user.data['name'];
              final y = user.data['email'];
              print('herre');

              final z = UserDeets(
                name: x,
                mail: y,
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

  final String name;
  final String mail;

  UserDeets({this.name, this.mail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(name),
        Text(mail),
      ],
    );
  }
}


