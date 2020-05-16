import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/screens/groups/edit_group.dart';

class AdminsList extends StatelessWidget {
  AdminsList({this.guid});
  final String guid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('groups')
            .document(guid)
            .collection('group_info')
            .document(guid)
            .collection('admins')
            .snapshots(),
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
          }
        });
  }

}
