import 'package:flutter/material.dart';
import 'package:hallo/screens/chats/chats.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';

import 'page1.dart';
import 'page2.dart';

class Add_friend extends StatefulWidget {
  String id = '/add_friend';

  @override
  _Add_friendState createState() => _Add_friendState();
}

class _Add_friendState extends State<Add_friend> {

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Nav_menu(),
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ChatSearch(
                    true
                  )
                );
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Add Friend"),
                    SizedBox(width: 10,),
                    Icon(Icons.person_add)
                  ],
                ),
              ),
              Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Friends"),
                  SizedBox(width: 10,),
                  Icon(Icons.list)
                ],
              ),
              ),
            ],
          ),
          title: Text('Friends'),
          backgroundColor: Theme
              .of(context)
              .accentColor,
        ),
        body: TabBarView(
          children: [
            new Add_Friends_Page(),
            new Friend_list_page2(),
          ],
        ),
      ),
    );
  }
}
