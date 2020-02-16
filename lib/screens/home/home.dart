
import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/add_friend.dart';
import 'package:hallo/screens/chats/chats.dart';
import 'package:hallo/screens/groups/groups.dart';
import 'package:hallo/screens/profile/profile.dart';

class Home extends StatefulWidget {

  String id = '/home';

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {




  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        initialRoute: '/chats',
        routes: {
          '/chats': (context) => Chats(),
          '/add_friend': (context) => Add_friend(),
          '/groups': (context) => Groups(),
          '/profile':(context) => Profile(),
        },


    );
  }
}