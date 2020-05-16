import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/screens/groups/edit_group.dart';

class AdminsList extends StatefulWidget {
  AdminsList({this.guid});

  final String guid;

  @override
  _AdminsListState createState() => _AdminsListState();
}

class _AdminsListState extends State<AdminsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('groups')
            .document(widget.guid)
            .collection('group_info')
            .document(widget.guid)
            .collection('admins')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            print(widget.guid);
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
