import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hallo/components/slidable_view.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/models/uid.dart';



class RequestStream extends StatelessWidget {


  Firestore _firestore = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:  _firestore
            .collection('user_profiles')
            .document('$current_user_uid')
            .collection('requests')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Na');
          } else {

            print('in else part');
            final listElements = snapshot.data.documents;
            List<UserDetailsReq> conversationList = [];
            for (var user in listElements) {
              final String uid = user.data['user_id'];
              print('$uid');

              final z = UserDetailsReq(
                friendUID: uid,
              );
              conversationList.add(z);
            }
            return Flexible(
              child: ListView(
                children: conversationList,
              ),
            );
          }
        });
  }
}
class UserDetailsReq extends StatelessWidget {

  final String friendUID;
  UserDetailsReq({this.friendUID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: friendUID).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('NA');
        } else {
          UserData userData = snapshot.data;
          return (SlidableView(
              friendName: userData.name,friendEmail: userData.email, imageURL: userData.imageUrl));
        }
      },
    );
  }
}
