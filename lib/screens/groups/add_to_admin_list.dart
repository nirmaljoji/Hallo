import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/add_friend/show_friends.dart';

class AddToAdminList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('user_profiles')
            .document('$current_user_uid')
            .collection('friends')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            final listElements = snapshot.data.documents;
            List<UserDeets> friendsThatAreNOtAdmins = [];
            for (var user in listElements) {
              final String uid = user.data['user_id'];

              final z = UserDeets(
                friendUID: uid,
                check: true,
              );
              friendsThatAreNOtAdmins.add(z);
            }

            return ListView(
              children: friendsThatAreNOtAdmins,
            );
          }
        });
  }
}
