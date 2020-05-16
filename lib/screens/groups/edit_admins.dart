import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/services/group_info.dart';

class EditAdmins extends StatefulWidget {
  final String guid;
  final String gname;

  EditAdmins({this.guid, this.gname});

  @override
  _EditAdminsState createState() => _EditAdminsState();
}

class _EditAdminsState extends State<EditAdmins> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('user_profiles')
            .document(current_user_uid)
            .collection('friends')
            .snapshots(),
        builder: (context, snapshot) {
          return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('groups')
                .document(widget.guid)
                .collection('group_info')
                .document(widget.guid)
                .collection('admins')
                .snapshots(),
            builder: (context, snapshot2) {
              if (!snapshot2.hasData) {
                return Center(
                  child: Text('naaa nothinggg'),
                );
              } else {
                GroupInfo.selectedFriends.clear();
                final listofAdmins = snapshot.data.documents;
                List<String> groupMembers = [];
                for (var i in listofAdmins) {
                  groupMembers.add(i.documentID);
                  GroupInfo(i.documentID);
                }
                final listOfFriends = snapshot2.data.documents;
                List<UserDeets2> adminList = [];
                for (var user in listOfFriends) {
                  final String uid = user.documentID;
                  var z;
                  if (groupMembers.contains(uid)) {
                    z = UserDeets2(
                      friendUID: uid,
                      bday: 2,
                    );
                  } else {
                    z = UserDeets2(
                      friendUID: uid,
                    );
                  }

                  adminList.add(z);
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Edit Admins'),
                  ),
                  body:
                  Column(
                    children: <Widget>[
                      ListView(
                        children: adminList,
                      ),
                      HalloButton(
                        text: 'submit',
                        onPressedBtn: () async {
                          final guid = await DatabaseService(
                              uid: current_user_uid).createGroup(
                              GroupInfo.selectedFriends, widget.gname);
                        },
                      )
                    ],
                  ),
                );
              }
            },
          );
        });
  }
}

class UserDeets2 extends StatefulWidget {
  int bday;
  String friendUID;

  UserDeets2({this.friendUID, this.bday});

  @override
  _UserDeets2State createState() => _UserDeets2State();
}

class _UserDeets2State extends State<UserDeets2> {
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: widget.friendUID).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else {
          UserData userData = snapshot.data;

          return GestureDetector(
            onLongPress: () {
              setState(() {
                widget.bday = 0;
                while (GroupInfo.selectedFriends.contains(widget.friendUID)) {
                  GroupInfo.selectedFriends.remove(widget.friendUID);
                }
                print(
                    'latest list after removal is ${GroupInfo
                        .selectedFriends})');
              });
            },
            child: ChatButton(
                friendName: userData.name,
                imageURL: userData.imageUrl,
                onPressed: () {
                  GroupInfo(widget.friendUID);
                  if (GroupInfo.selectedFriends.contains(widget.friendUID)) {
                    setState(() {
                      widget.bday = 2;
                    });
                  }
                }),
          );
        }
      },
    );
  }
}
