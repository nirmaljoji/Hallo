import 'package:flutter/material.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/wrapper.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/shared/hallo_theme_data.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  HalloThemeData data = new HalloThemeData();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
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
            ),
            title: TextStyle(
              //fontSize: 20,
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
        home: Wrapper(),
      ),
    );
  }
}
