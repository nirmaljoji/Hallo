import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/models/selected.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/services/database.dart';
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
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: current_user_uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Drawer(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 140,
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 7, 5, 10),
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
                                        context,
                                        '/${_listViewRouteData[index]}');
                                  });
                                },
                              ),
                            );
                          }),
                    ),

                    Expanded(

                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 25, horizontal: 0),
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
                )
            );
          }
          else {
            UserData userData = snapshot.data;
            return Drawer(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
                      width: 310,
                      color: Theme
                          .of(context)
                          .accentColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 70.0,
                            child: ClipOval(
                              child: new Container(
                                width: 180,
                                height: 180,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: userData.imageUrl != null
                                        ? (new NetworkImage(
                                        userData.imageUrl))
                                        : new AssetImage('images/user1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('  ${userData.name}',
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .backgroundColor,
                              fontSize: 25.0,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ],
                      ),
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
                                title: Text(
                                  _listViewData[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme
                                        .of(context)
                                        .highlightColor,
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    ch.currentSelected = index;
                                    Navigator.pushReplacementNamed(
                                        context,
                                        '/${_listViewRouteData[index]}');
                                  });
                                },
                              ),
                            );
                          }),
                    ),

                    Expanded(

                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 25, horizontal: 0),
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
                )
            );
          }
        }
    );

  }
}
