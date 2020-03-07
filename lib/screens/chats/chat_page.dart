import 'package:flutter/material.dart';
import 'package:hallo/screens/chats/message_stream.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.friendUID});

  final String friendUID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendUID),
        backgroundColor: Theme
            .of(context)
            .accentColor,
      ),
      body: SafeArea(
        child: MessagesStream(
          friendUID: friendUID,
        ),
      ),
    );
  }
}
