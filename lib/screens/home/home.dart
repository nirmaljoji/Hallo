import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/add_friend.dart';
import 'package:hallo/screens/authenticate/authenticate.dart';
import 'package:hallo/screens/authenticate/forgot_pwd.dart';
import 'package:hallo/screens/chats/chats.dart';
import 'package:hallo/screens/groups/groups.dart';
import 'package:hallo/screens/profile/profile.dart';
import 'package:hallo/shared/hallo_theme_data.dart';

class Home extends StatefulWidget {
  String id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    HalloThemeData data = new HalloThemeData();

    return MaterialApp(
      initialRoute: '/chats',
      routes: {
        '/chats': (context) => Chats(),
        '/add_friend': (context) => Add_friend(),
        '/groups': (context) => Groups(),
        '/profile': (context) => Profile(),
        '/login':(context) => Authenticate(),
        '/forgot':(context) => ForgotPwd(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: data.primaryColor,
        accentColor: data.accentColor,
        cardColor: data.cardColor,
        backgroundColor: data.backgroundColor,
        canvasColor: data.canvasColor,
        buttonColor: data.btnColor,
        splashColor: data.splashColor,
        focusColor: data.focusColor,
        highlightColor: data.highlightColor,
        hintColor: data.hintColor,
        cursorColor: data.cursorColor,
        errorColor: data.errorColor,
        primaryColorDark: data.primaryColorDark,
        primaryColorLight: data.primaryColorLight,
        /*
          subhead - profile headings- subhead
          subtitle - profile data, nav menu items, chat names
          body1 - textfields,chats
          body2-hints
           */
        textTheme: TextTheme(
          headline: TextStyle(
            color: data.primaryColor,
            fontFamily: data.headlineFont,
              fontWeight: FontWeight.bold,
              fontSize: 25.0
          ),
          title: TextStyle(
            fontSize: 50,
            color: Colors.black,
            fontFamily: data.titleFont,
          ),
          subhead: TextStyle(
            color: data.accentColor,
            fontFamily: data.headlineFont,
          ),
          body1: TextStyle(
            color: data.primaryColor,
            fontFamily: data.headlineFont,
          ),
          body2: TextStyle(
            color: data.hintColor,
            fontFamily: data.headlineFont,
          ),
          button: TextStyle(
            color: data.cursorColor,
            fontFamily: data.headlineFont,
          ),
          subtitle: TextStyle(
            fontFamily: data.headlineFont,
              color: Theme
                  .of(context)
                  .highlightColor,
              fontSize: 18.0
          ),
        ),
      ),
    );
    //
  }
}
