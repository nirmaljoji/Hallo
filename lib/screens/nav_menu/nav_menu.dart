import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/models/selected.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/shared/hallo_theme_data.dart';

class Nav_menu extends StatefulWidget {
  @override
  _Nav_menuState createState() => _Nav_menuState();
}

Selected ch = new Selected();

class DrawerItem {
  IconData icon;

  DrawerItem({this.icon});
}

class _Nav_menuState extends State<Nav_menu> {
  Future returnUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return (user.uid);
  }

  static final List<String> _listViewData = [
    "Chats",
    "Groups",
    "Add Friend",
    "Profile",
  ];

  final AuthService _auth = AuthService();

  static final List<String> _listViewRouteData = [
    "chats",
    "groups",
    "add_friend",
    "profile",
  ];

  final drawerItems = [
    new DrawerItem(icon: Icons.chat),
    new DrawerItem(icon: Icons.group),
    new DrawerItem(icon: Icons.person_add),
    new DrawerItem(icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    HalloThemeData data = new HalloThemeData();
    double ht = MediaQuery.of(context).size.height;
    ht -= 193 + 26;
    return Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10.0),
                  itemCount: _Nav_menuState._listViewData.length,
                  itemBuilder: (context, index) {
                    print(ch.currentSelected);
                    return Container(
                      color: ch.currentSelected == index
                          ? Theme
                          .of(context)
                          .focusColor
                          : Colors.white,
                      child: ListTile(
                        leading: new Icon(drawerItems[index].icon),
                        title: Text(_listViewData[index]),
                        onTap: () async {
                          setState(() {
                            print("index  $index");
                            ch.currentSelected = index;
                            Navigator.pushReplacementNamed(
                                context, '/${_listViewRouteData[index]}');
                          });
                        },
                      ),
                    );
                  }),
            ),
            
            Expanded(

              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25,horizontal: 0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: HalloButton(
                    color1: data.btnColor,
                    color2: data.cardColor,
                    text: 'Sign out',
                    onPressedBtn: () async {
                      await _auth.signOut();
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}


