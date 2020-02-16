import 'package:flutter/material.dart';
import 'package:hallo/screens/authenticate/register.dart';
import 'package:hallo/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {

  String id = '/authenticate';

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}