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
          primaryColor: Color(0xFF173F5F),
          accentColor: Color(0xFF20639B),
          cardColor: Color(0xFFFAFAFA),
          backgroundColor: Color(0xFF3CAEA3),
          canvasColor: Color(0xFFFAFAFA),
          buttonColor: Color(0xFFED553B),
          splashColor: Color(0xFFED553B),
          //        focusColor: Color(0xFF000000),

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
        home: Wrapper(),
      ),
    );
  }
}
