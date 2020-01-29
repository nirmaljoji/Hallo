import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hallo"),
        centerTitle: true,
        backgroundColor: Colors.grey[400]
        ,


      ),

      body: Text("This is where the Dasgboard will go"),
    );
  }
}

