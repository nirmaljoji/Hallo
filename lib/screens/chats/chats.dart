import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/show_friends.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/auth.dart';


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {


  final AuthService _auth = AuthService();

//  void getConversationList() async {
//    print('list of all converstions');
//    await for (var snapshot in _firestore.collection('messages').snapshots()) {
//      for (var convo in snapshot.documents) {
//        print(convo.data);
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.amber,
        onPressed: () {
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

/*

return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: <Widget>[
            ChatButton(
              friendName: friendUID,
              onPressed: () {
                print('hey it worksss');
              },
            ),
          ]
      ),
    );
 */




