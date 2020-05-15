import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/show_friends.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Group",
          style: Theme
              .of(context)
              .textTheme
              .title,
        ),
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        elevation: 4,
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .backgroundColor,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: TextField()),
            Expanded(
                flex: 13,
                child: ListStream(check: true))
          ],
        ),

        //Text('New message to: '),
      ),
    );
  }
}
