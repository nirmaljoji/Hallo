import 'package:flutter/material.dart';
import 'package:hallo/screens/groups/add_to_admin_list.dart';
import 'package:hallo/shared/admins_list.dart';

class EditAdmin extends StatefulWidget {
  final String guid;

  EditAdmin({this.guid});

  @override
  _EditAdminState createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Admin raks",
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
            Expanded(flex: 1, child: Text('Admins : ')),
            Expanded(flex: 10, child: AdminsList(guid: widget.guid)),
            Expanded(flex: 10, child: AddToAdminList())
          ],
        ),
      ),
    );
  }
}
