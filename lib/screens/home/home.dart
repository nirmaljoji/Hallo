
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

      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFdf7861),
        accentColor: Color(0xFFecb390),
        cardColor: Color(0xFFFAFAFA),
        backgroundColor: Color(0xFFe9e1cc),
        canvasColor: Color(0xFFe9e1cc),
        buttonColor: Color(0xFFd45079),
        splashColor: Color(0xFFED553B),
        focusColor: Color(0xFF3CAEA3),
        highlightColor: Color(0xFFF6D55C),
        hintColor: Color(0xFF3CAEA3),
        cursorColor: Color(0xFFFAFAFA),
        errorColor: Color(0xFFB71C1C),
        primaryColorDark: Color(0xFFB71C1C),
        primaryColorLight: Color(0xFFB71C1C),
        /*
          subhead - profile headings- subhead
          subtitle - profile data, nav menu items, chat names
          body1 - textfields,chats
          body2-hints
           */
        textTheme: TextTheme(
          headline: TextStyle(
            color: Theme
                .of(context)
                .primaryColor,
          ),
          title: TextStyle(color: Theme
              .of(context)
              .highlightColor),
          subhead: TextStyle(
            color: Theme
                .of(context)
                .accentColor,
          ),
          body1: TextStyle(
            color: Theme
                .of(context)
                .primaryColor,
          ),
          body2: TextStyle(
            color: Theme
                .of(context)
                .hintColor,
          ),
          button: TextStyle(color: Theme
              .of(context)
              .highlightColor),
          subtitle: TextStyle(
            color: Theme
                .of(context)
                .primaryColor,
          ),
        ),
      ),
    );
  }
}