import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/show_friends.dart';

class Friend_list_page2 extends StatefulWidget {

  final String query;

  const Friend_list_page2({this.query});

  @override
  _Friend_list_page2State createState() => _Friend_list_page2State();
}

class _Friend_list_page2State extends State<Friend_list_page2> {

  @override
  Widget build(BuildContext context) {
    return ListStream(
        check: false,
        query: widget.query,
    );
  }
}
