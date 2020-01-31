import 'package:hallo/screens/wrapper.dart';
import 'package:hallo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/profile/profile.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthService().user,

      child: MaterialApp(


        home:Wrapper(),
      ),
    );

  }
}

