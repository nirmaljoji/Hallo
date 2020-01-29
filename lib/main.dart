import 'package:flutter/material.dart';
import 'package:hallo/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hallo"),
          backgroundColor: Colors.grey[800],
          centerTitle: true,
        ),

        body: Wrapper(),

      ),
    );
  }
}
