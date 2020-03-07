import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.friendUID});

  final String friendUID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendUID),
      ),
    );
  }
}
