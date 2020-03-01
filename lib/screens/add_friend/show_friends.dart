import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              child: Center(

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

  UserDeets({this.friendUID, this.bday});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: friendUID).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('NA');
        } else {
          UserData userData = snapshot.data;
          int date = DateTime.now().day;
          int mnth = DateTime.now().month;
          int user_date = userData.dob.toDate().day;
          int user_mnth = userData.dob.toDate().month;
          if(date == user_date && mnth == user_mnth)
            bday = 1;
          return (ChatButton(
              friendName: userData.name, imageURL: userData.imageUrl, bDay: this.bday));
        }
      },
    );
  }
}
