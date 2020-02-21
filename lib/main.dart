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
          primaryColor: Color(0xFF512E67),
          accentColor: Color(0xFFA3A7E4),
          cardColor: Color(0xFF112233),
          backgroundColor: Color(0xFFE91E63),
          canvasColor: Color(0xFFB71C1C),
          buttonColor: Color(0xFFFF9800),
          splashColor: Color(0xFFB2FF59),
          focusColor: Color(0xFF009688),
          highlightColor: Color(0xFF795548),
          //fontFamily: '',
          textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(
              //fontSize:,
              //fontStyle: ,
            ),
              body2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              button: TextStyle(fontSize: 14.0, fontFamily: 'Hind')
          ),
        ),
        home:Wrapper(),
      ),
    );
  }
}

