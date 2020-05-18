import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/chats/chat_page.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/services/group_info.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ListStream extends StatelessWidget {
  Firestore _firestore = Firestore.instance;
  bool loading = false;
  String query;
  //to check if group/friend
  bool check;

  ListStream({this.check, this.query});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('user_profiles')
            .document('$current_user_uid')
            .collection('friends')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            loading = true;
            return ModalProgressHUD(
              inAsyncCall: loading,
              child: Text(''),
            );
          } else {
            final listElements = snapshot.data.documents;
            List<UserDeets> conversationList = [];
            for (var user in listElements) {
              final String uid = user.data['user_id'];

              final z = UserDeets(
                friendUID: uid,
                check: check,
                query: query,
              );
              conversationList.add(z);
            }
            loading = false;
            return ListView(
              children: conversationList,
            );
          }
        });
  }
}

class UserDeets extends StatefulWidget {
  final String friendUID;
  int bday;
  bool check;
  String query;
  UserDeets({this.friendUID, this.bday, this.check, this.query});

  @override
  _UserDeetsState createState() => _UserDeetsState();
}

class _UserDeetsState extends State<UserDeets> {
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
          int date = DateTime
              .now()
              .day;
          int mnth = DateTime
              .now()
              .month;
          int user_date;
          int user_mnth;
          if (userData.dob != null) {
            user_date = userData.dob
                .toDate()
                .day;
            user_mnth = userData.dob
                .toDate()
                .month;
          }
          if (date == user_date && mnth == user_mnth && widget.check != true)
            widget.bday = 1;

          if(widget.query == '' || widget.query == null){
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  widget.bday = 0;
                  while (GroupInfo.selectedFriends.contains(widget.friendUID)) {
                    GroupInfo.selectedFriends.remove(widget.friendUID);
                  }
                  print('latest list after removal is ${GroupInfo
                      .selectedFriends})');
                });
              },
              child: ChatButton(
                  group: true,
                  guid: null,
                  friendName: userData.name,
                  imageURL: userData.imageUrl,
                  icon: this.widget.bday,
                  onPressed: () {
                    if (widget.check) {
                      GroupInfo(widget.friendUID);
                      if (GroupInfo.selectedFriends.contains(
                          widget.friendUID)) {
                        setState(() {
                          widget.bday = 2;
                        });
                      }
                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              NetworkGiffyDialog(
                                buttonOkText: Text('Say Hello!'),
                                buttonCancelText: Text('Delete friend'),
                                buttonCancelColor: Colors.red.shade400,
                                image: CircleAvatar(
                                  radius: 40,
                                  child: ClipOval(
                                    child: new SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: userData.imageUrl != null
                                            ? Image.network(
                                          userData.imageUrl,
                                          fit: BoxFit.cover,
                                        )
                                            : Container(
                                          //color: Theme.of(context).backgroundColor,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                AssetImage('images/user.png'),
                                              )),
                                        )),
                                  ),
                                ),
                                title: Text('${userData.name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                                description: Text(userData.email),
                                entryAnimation: EntryAnimation.BOTTOM,
                                onOkButtonPressed: () {
                                  //Navigator.pushNamed(context, '/chats');
                                  _firestore
                                      .collection('user_profiles')
                                      .document('$current_user_uid')
                                      .collection('friends')
                                      .document('${widget.friendUID}')
                                      .updateData({'chat': true});
                                  _firestore
                                      .collection('user_profiles')
                                      .document('${widget.friendUID}')
                                      .collection('friends')
                                      .document('$current_user_uid')
                                      .updateData({'chat': true});
                                  try {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatPage(
                                                  friendUID: widget.friendUID,
                                                  fname: userData.name,
                                                )));
                                    _firestore
                                        .collection('messages')
                                        .document(current_user_uid)
                                        .collection(widget.friendUID)
                                        .add({
                                      'text': 'Hello!',
                                      'time': FieldValue.serverTimestamp(),
                                      'to': widget.friendUID,
                                      'from': current_user_uid,
                                    });

                                    _firestore
                                        .collection('messages')
                                        .document(widget.friendUID)
                                        .collection(current_user_uid)
                                        .add({
                                      'text': 'Hello!',
                                      'time': FieldValue.serverTimestamp(),
                                      'from': current_user_uid,
                                      'to': widget.friendUID,
                                    });
                                  } catch (e) {
                                    print(e);
                                    print('nothing there no chat yet');
                                  }
                                },
                                onCancelButtonPressed: () {
                                  _firestore
                                      .collection('user_profiles')
                                      .document('$current_user_uid')
                                      .collection('friends')
                                      .document(widget.friendUID)
                                      .delete();
                                  _firestore
                                      .collection('user_profiles')
                                      .document(widget.friendUID)
                                      .collection('friends')
                                      .document(current_user_uid)
                                      .delete();
                                },
                              ));
                    }
                  }),
            );

          } else if(userData.name.toLowerCase().contains(widget.query.toLowerCase())) {
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  widget.bday = 0;
                  while (GroupInfo.selectedFriends.contains(widget.friendUID)) {
                    GroupInfo.selectedFriends.remove(widget.friendUID);
                  }
                  print('latest list after removal is ${GroupInfo
                      .selectedFriends})');
                });
              },
              child: ChatButton(
                  friendName: userData.name,
                  imageURL: userData.imageUrl,
                  icon: this.widget.bday,
                  onPressed: () {
                    if (widget.check) {
                      GroupInfo(widget.friendUID);
                      if (GroupInfo.selectedFriends.contains(
                          widget.friendUID)) {
                        setState(() {
                          widget.bday = 2;
                        });
                      }
                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              NetworkGiffyDialog(
                                buttonOkText: Text('Say Hello!'),
                                buttonCancelText: Text('Delete friend'),
                                buttonCancelColor: Colors.red.shade400,
                                image: CircleAvatar(
                                  radius: 40,
                                  child: ClipOval(
                                    child: new SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: userData.imageUrl != null
                                            ? Image.network(
                                          userData.imageUrl,
                                          fit: BoxFit.cover,
                                        )
                                            : Container(
                                          //color: Theme.of(context).backgroundColor,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                AssetImage('images/user.png'),
                                              )),
                                        )),
                                  ),
                                ),
                                title: Text('${userData.name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                                description: Text(userData.email),
                                entryAnimation: EntryAnimation.BOTTOM,
                                onOkButtonPressed: () {
                                  //Navigator.pushNamed(context, '/chats');
                                  _firestore
                                      .collection('user_profiles')
                                      .document('$current_user_uid')
                                      .collection('friends')
                                      .document('${widget.friendUID}')
                                      .updateData({'chat': true});
                                  _firestore
                                      .collection('user_profiles')
                                      .document('${widget.friendUID}')
                                      .collection('friends')
                                      .document('$current_user_uid')
                                      .updateData({'chat': true});
                                  try {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatPage(
                                                  friendUID: widget.friendUID,
                                                  fname: userData.name,
                                                )));
                                    _firestore
                                        .collection('messages')
                                        .document(current_user_uid)
                                        .collection(widget.friendUID)
                                        .add({
                                      'text': 'Hello!',
                                      'time': FieldValue.serverTimestamp(),
                                      'to': widget.friendUID,
                                      'from': current_user_uid,
                                    });

                                    _firestore
                                        .collection('messages')
                                        .document(widget.friendUID)
                                        .collection(current_user_uid)
                                        .add({
                                      'text': 'Hello!',
                                      'time': FieldValue.serverTimestamp(),
                                      'from': current_user_uid,
                                      'to': widget.friendUID,
                                    });
                                  } catch (e) {
                                    print(e);
                                    print('nothing there no chat yet');
                                  }
                                },
                                onCancelButtonPressed: () {
                                  _firestore
                                      .collection('user_profiles')
                                      .document('$current_user_uid')
                                      .collection('friends')
                                      .document(widget.friendUID)
                                      .delete();
                                  _firestore
                                      .collection('user_profiles')
                                      .document(widget.friendUID)
                                      .collection('friends')
                                      .document(current_user_uid)
                                      .delete();
                                },
                              ));
                    }
                  }),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
