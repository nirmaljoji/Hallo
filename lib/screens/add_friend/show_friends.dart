import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:hallo/components/chat_button.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ListStream extends StatelessWidget {
  Firestore _firestore = Firestore.instance;
  bool loading = false;
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
              child: Text(
                  ''
              ),
            );
          } else {
            final listElements = snapshot.data.documents;
            List<UserDeets> conversationList = [];
            for (var user in listElements) {
              final String uid = user.data['user_id'];
              print('$uid');

              final z = UserDeets(
                friendUID: uid,
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

class UserDeets extends StatelessWidget {
  final String friendUID;
  int bday;
  Firestore _firestore = Firestore.instance;
  UserDeets({this.friendUID, this.bday});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: friendUID).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else {
          UserData userData = snapshot.data;
          int date = DateTime.now().day;
          int mnth = DateTime.now().month;
          int user_date;
          int user_mnth;
          if(userData.dob!=null) {
             user_date = userData.dob
                .toDate()
                .day;
            user_mnth = userData.dob
                .toDate()
                .month;
          }
          if(date == user_date && mnth==user_mnth)
            bday = 1;
          return (
              ChatButton(
                friendName: userData.name,
                imageURL: userData.imageUrl,
                bDay: this.bday,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          NetworkGiffyDialog(
                            buttonOkText: Text('Chat'),
                            buttonCancelText: Text('Delete friend'),
                            buttonCancelColor: Colors.red.shade400,
                            image: CircleAvatar(
                              radius: 40,
                              child: ClipOval(
                                child: new SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: userData.imageUrl != null ? Image
                                        .network(
                                      userData.imageUrl,
                                      fit: BoxFit.cover,
                                    ) : Container(
                                      //color: Theme.of(context).backgroundColor,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/user.png'),
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ),
                            title: Text('${userData.name}',
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(fontSize: 22.0,
                                    fontWeight: FontWeight.w600,color: Colors.white)
                            ),
                            description: Text(userData.email),
                            entryAnimation: EntryAnimation.BOTTOM,
                            onOkButtonPressed: () {
                              Navigator.pushNamed(context, '/chats');
                            },
                            onCancelButtonPressed: () {
                              _firestore.collection('user_profiles').document(
                                  '$current_user_uid')
                                  .collection('friends')
                                  .document(friendUID)
                                  .delete();
                              _firestore.collection('user_profiles').document(
                                  friendUID).collection('friends').document(
                                  current_user_uid).delete();
                            },
                          )
                  );
                },
              )
          );
        }
      },
    );
  }

}
