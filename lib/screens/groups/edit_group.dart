import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/add_friend/initiate_chat.dart';
import 'package:hallo/screens/groups/edit_admins.dart';
import 'package:hallo/screens/groups/edit_members.dart';

class AdminsDetails extends StatelessWidget {
  Firestore _firestore = Firestore.instance;
  String userUID;
  AdminsDetails({this.userUID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('user_profiles')
            .document('$userUID')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            return FriendDetails(
              friendUID: userUID,
            );
          }
        });
  }
}

class EditGroup extends StatefulWidget {
  String groupName;
  String groupUID;

  EditGroup({this.groupUID, this.groupName});

  @override
  _EditGroupState createState() =>
      _EditGroupState(groupName: groupName, groupUID: groupUID);
}

class _EditGroupState extends State<EditGroup> {
  _EditGroupState({this.groupName, this.groupUID});
  bool checkCurrent;
  String groupName;
  String groupUID;
  Firestore _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    Stream str = _firestore
        .collection('groups')
        .document(groupUID)
        .collection('group_info')
        .document(groupUID)
        .collection('admins')
        .snapshots();

    Widget AdminList() {
      return StreamBuilder<QuerySnapshot>(
          stream: str,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              List<AdminsDetails> adminsList = [];
              for (var i in snapshot.data.documents) {

                final z = AdminsDetails(userUID: i.documentID);
                adminsList.add(z);
              }
              return ListView(
                children: adminsList,
              );
              ;
            }
          });
    }

    Widget _buttonsGroup(String guid) {

      return StreamBuilder<QuerySnapshot>(
        stream :str,
        builder: (context,snapshot)
      {
        bool check = false;
        if (!snapshot.hasData) {
          return Text('');
        } else {
          for (var i in snapshot.data.documents) {
            if (i.documentID == current_user_uid) {
              check = true;
              break;
            }
          }
          if (check) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditAdmins()
                      ),);
                  },
                  child: Text('Edit Admins'),
                ),
                SizedBox(
                  width: 100,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditMembers()
                      ),);
                  },
                  child: Text('Edit Members'),
                ),
              ],
            );
          }
          else {
            return Text('');
          }
        }
      });
    }




    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Group",
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 4,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Group Name',
              style: TextStyle(fontSize: 25),
            ),
            Expanded(
                flex: 4,
                child: HalloTextField(
                  text: 'Do not leave blank',
                  hint: '$groupName',
                  isPassword: false,
                  onChangedText: (val) {
                    setState(() {
                      groupName = val;
                    });
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Admins',
              style: TextStyle(fontSize: 25),
            ),
            Expanded(flex: 15, child: AdminList()),
            Expanded(
              flex: 3,
              child:  _buttonsGroup(groupUID),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {},
                child: Text('Create'),
              ),
            )
          ],
        ),
        //Text('New message to: '),
      ),
    );
  }
}
