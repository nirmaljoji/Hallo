
import 'package:flutter/material.dart';
import 'package:hallo/services/auth.dart';

    class Home extends StatefulWidget {
      @override
      _HomeState createState() => _HomeState();
    }

    class _HomeState extends State<Home> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Text("This is user home page "),
        );
      }
    }
