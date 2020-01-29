//Listen to Stream of and check for whether is user has logged in or logged out


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hallo/screens/home.dart';
import 'package:hallo/screens/authenticate/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    //should return either authentication wideget tree or Home widget tree

    return Container(
    child:SafeArea(
      child:Text("THIS IS WRAPPER")
    )
    );
  }
}
