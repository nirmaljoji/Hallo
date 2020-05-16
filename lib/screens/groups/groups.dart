import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/models/group.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/groups/group_page.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/database.dart';

class Groups extends StatefulWidget {
  String id = '/groups';

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    Widget func() {

      return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .document('$current_user_uid')
            .collection('groups_chat')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Text('nothing here ra dumma'),
            );
          } else {
            //snapshot.data.documents gets added as a list only if it has atleast ONE field!!!!!
            //for a doc to be valid it MUST have atleast one key value pairrrrr
            final listOfGroups = snapshot.data.documents;
            print(listOfGroups);
            List<ChattedGroup> chattedPeopleList = [];
            for (var group in listOfGroups) {
              final String guid = group.documentID;
              print('a group you are part of is $guid');

              final box = ChattedGroup(
                groupUID: guid,
              );

              chattedPeopleList.add(box);
            }
            return ListView(
              children: chattedPeopleList,
            );
          }
        },
      );
    }

    return Scaffold(


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Theme
            .of(context)
            .splashColor,
        onPressed: () {
          setState(() {});
        },
      ),
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      drawer: Nav_menu(),
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        title: Text("Groups ok"),
      ),
      body: Container(
        child: func(),
      ),
    );
  }
}

class ChattedGroup extends StatelessWidget {
  final String groupUID;

  ChattedGroup({this.groupUID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GroupData>(
      stream: DatabaseService(uid: groupUID).groupData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text('no'));
        } else {
          GroupData groupData = snapshot.data;
          return ChatButton(
              friendName: groupData.name,
              onPressed: () {

                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) =>
                        GroupPage(groupUID: groupData.uid,
                          fname: groupData.name,)));

              },

          );
        }
      },
    );
  }
}
