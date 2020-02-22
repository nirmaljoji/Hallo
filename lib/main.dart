import 'package:flutter/material.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/wrapper.dart';
import 'package:hallo/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF512E67),
          accentColor: Color(0xFFA3A7E4),
          cardColor: Color(0xFF112233),
          backgroundColor: Color(0xFFEAAE63),
          canvasColor: Color(0xFF11FF33),
          buttonColor: Color(0xFFAA9800),
          splashColor: Color(0xFFB2FF59),
          //        focusColor: Color(0xFF000000),

          focusColor: Color(0xFF009688),
          highlightColor: Color(0xFF795548),
          hintColor: Color(0xFFB71aaa),
          cursorColor: Color(0xFFEE1A55),
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
        home: Wrapper(),
      ),
    );
  }
}
