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
      value:AuthService().user,

      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFFAFAFA),
          accentColor: Color(0xFFA3A7E4),
          cardColor: Color(0xFF512E67),
          //fontFamily: '',
          textTheme: TextTheme(
            headline: TextStyle(
              //fontSize:,
              //fontStyle: ,
            ),
            title: TextStyle(
              //fontSize:,
              //fontStyle: ,
            ),
            body1: TextStyle(
              //fontSize:,
              //fontStyle: ,
            ),
            button: TextStyle(
              color: Color(0xFFFAFAFA),
            ),
          ),
        ),
        home:Wrapper(),
      ),
    );
  }
}

