import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/show_friends.dart';
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
                  delegate: FriendSearch(),
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



class FriendSearch extends SearchDelegate<UserDeets>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return new Friend_list_page2(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return new Friend_list_page2(
      query: query,
    );
  }

}
