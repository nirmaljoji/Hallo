import "package:flutter/material.dart";
import 'package:hallo/models/selected.dart';

class Nav_menu extends StatefulWidget {
  @override
  _Nav_menuState createState() => _Nav_menuState();
}


class DrawerItem{
  IconData icon;
  DrawerItem({this.icon});
}


class _Nav_menuState extends State<Nav_menu> {
  static final List<String> _listViewData = [
    "Chats",
    "Groups",
    "Add Friend",
    "Profile",
  ];





  static final List<String> _listViewRouteData = [
    "chats",
    "groups",
    "add_friend",
    "profile",
  ];

  final drawerItems= [
    new DrawerItem(icon: Icons.chat),
    new DrawerItem(icon: Icons.group),
    new DrawerItem(icon: Icons.person_add),
    new DrawerItem(icon: Icons.person),


  ];



  @override
  Widget build(BuildContext context) {
//    return Drawer(
//      child: Container(
//        child: ListView.builder(
//          padding: EdgeInsets.all(10.0),
//          itemCount: _Nav_menuState._listViewData.length,
//          itemBuilder: (context, index) {
//            return Container(
//              color: _currentSelected == index ? Colors.red : Colors.white,
//              child: ListTile(
//                title: Text(_listViewData[index]),
//                onTap: () {
//                  setState(() {
//                    _currentSelected = index;
//                  });
//                },
//              ),
//            );
//          },
//        ),
//      ),
//    );

    double ht = MediaQuery.of(context).size.height;
    ht -= 193;
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        // Important: Remove any padding from the ListView.

        child: Column(
      children: <Widget>[
        Container(
          height: 200,
          color: Colors.blue,
        ),

        Container(
          height: ht,
          child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _Nav_menuState._listViewData.length,
              itemBuilder: (context, index) {
                return Container(
                  color:
                      ch.currentSelected == index ? Colors.red : Colors.white,
                  child: ListTile(
                    leading: new Icon(drawerItems[index].icon),
                    title: Text(_listViewData[index]),

                    onTap: () async {
                      setState(() {
                        print("index  $index");
                        ch.currentSelected = index;
                        Navigator.pushReplacementNamed(
                            context, '/${_listViewRouteData[index]}');
                        print("Current ${ch.currentSelected}");
                      });
                    },
                  ),
                );
              }),
        ),
      ],
    ));

//              onTap: () {
//                Navigator.pushReplacementNamed(context, '/');
//              },
//            ),
//          ),
//          ListTile(
//            title: Text('Groups'),
//            onTap: () {
//              // Update the state of the app.
//              // ...
//              Navigator.pushReplacementNamed(context, '/groups');
//            },
//          ),
//          ListTile(
//            title: Text('Add Friend'),
//            onTap: () {
//              Navigator.pushReplacementNamed(context, '/add_friend');
//            },
//          ),
//          ListTile(
//            title: Text('Profile'),
//            onTap: () {
//              Navigator.pushReplacementNamed(context, '/profile');
//              // Update the state of the app.
//              // ...
//            },
//          ),
//        ],
//      ),
  }
}
