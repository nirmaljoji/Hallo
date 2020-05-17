import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/add_friend/initiate_chat.dart';
import 'package:hallo/screens/groups/edit_admins.dart';
import 'package:hallo/screens/groups/edit_members.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/shared/admins_list.dart';
import 'package:hallo/shared/hallo_theme_data.dart';

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

  Widget _buttonsGroup(String guid) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('groups')
            .document(groupUID)
            .collection('group_info')
            .document(groupUID)
            .collection('admins')
            .snapshots(),
        builder: (context, snapshot) {
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
            HalloThemeData data = new HalloThemeData();
            if (check) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  HalloButton(
                    color1: data.btnColor,
                    color2: data.cardColor,
                    text: 'Members',
                    onPressedBtn: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MembersList(
                                guid: groupUID, gname: groupName) //sharons page
                            //EditAdmin(guid: groupUID,) //raks screen
                            ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      HalloButton(
                        color1: data.primaryColorDark,
                        color2: data.primaryColorLight,
                        text: 'Edit Admins',
                        onPressedBtn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditAdmins(
                                        guid: groupUID,
                                        gname: groupName) //sharons page
                              //EditAdmin(guid: groupUID,) //raks screen
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      HalloButton(
                        color1: data.primaryColorDark,
                        color2: data.primaryColorLight,
                        text: 'Edit Members',
                        onPressedBtn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditMembers(
                                        guid: groupUID, gname: groupName)),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Row(
                children: <Widget>[
                  HalloButton(
                    color1: data.btnColor,
                    color2: data.cardColor,
                    text: 'Members',
                    onPressedBtn: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MembersList(
                                guid: groupUID, gname: groupName) //sharons page
                          //EditAdmin(guid: groupUID,) //raks screen
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    HalloThemeData data = new HalloThemeData();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              Firestore.instance
                  .collection('messages')
                  .document(current_user_uid)
                  .collection('groups_chat')
                  .document(widget.groupUID)
                  .collection('Chats')
                  .getDocuments()
                  .then((snapshot) {
                for (DocumentSnapshot ds in snapshot.documents) {
                  Firestore.instance
                      .collection('messages')
                      .document(current_user_uid)
                      .collection('groups_chat')
                      .document(widget.groupUID)
                      .collection('Chats')
                      .document(ds.documentID)
                      .delete();
                }
              });

              await Firestore.instance
                  .collection('groups')
                  .document(widget.groupUID)
                  .collection('group_members')
                  .document(current_user_uid)
                  .delete();
              await Firestore.instance
                  .collection('messages')
                  .document(current_user_uid)
                  .collection('groups_chat')
                  .document(widget.groupUID)
                  .delete();
              await Firestore.instance
                  .collection('groups')
                  .document(widget.groupUID)
                  .collection('group_info')
                  .document(widget.groupUID)
                  .collection('admins')
                  .document(current_user_uid)
                  .delete();
              Navigator.pushNamed(context, '/groups');
            },
          )
        ],
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
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
              Expanded(flex: 10, child: AdminsList(guid: groupUID)),
              Expanded(
                flex: 5,
                child: Center(child: _buttonsGroup(groupUID)),
              ),
              Container(
                width: 400,
                child: HalloButton(
                  color1: data.btnColor,
                  color2: data.cardColor,
                  text: 'Done',
                  onPressedBtn: () async {
                    Firestore.instance
                        .collection('groups')
                        .document(groupUID)
                        .collection('group_info')
                        .document(groupUID)
                        .updateData({'group_name': groupName});
                    Navigator.pushNamed(context, '/groups');
                  },
                ),
              )
            ],
          ),
        ),
        //Text('New message to: '),
      ),
    );
  }
}

class MembersList extends StatefulWidget {
  String guid;
  String gname;

  MembersList({this.guid, this.gname});

  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('groups')
            .document(widget.guid)
            .collection('group_members')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            List<String> memList = [];
            for (var i in snapshot.data.documents) {
              memList.add(i.documentID);
            }
            List<UserDeets3> memListWidget = [];
            for (var user in memList) {
              var z;

              z = UserDeets3(
                friendUID: user,
              );

              memListWidget.add(z);
            }
            int memCount = memListWidget.length;
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Text('$memCount'),
                backgroundColor: Theme.of(context).splashColor,
              ),
              appBar: AppBar(
                title: Text('Group Members'),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: memListWidget,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class UserDeets3 extends StatefulWidget {
  String friendUID;

  UserDeets3({this.friendUID});

  @override
  _UserDeets3State createState() => _UserDeets3State();
}

class _UserDeets3State extends State<UserDeets3> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: widget.friendUID).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            UserData userData = snapshot.data;
            return ChatButton(
                friendName: userData.name,
                imageURL: userData.imageUrl,
                onPressed: null);
          }
        });
  }
}
