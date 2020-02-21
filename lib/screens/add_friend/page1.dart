import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/screens/add_friend/request_stream.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/models/uid.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Add_Friends_Page extends StatefulWidget {
  @override
  _Add_Friends_PageState createState() => _Add_Friends_PageState();
}

class _Add_Friends_PageState extends State<Add_Friends_Page> {
  void _showToast1(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent[200],
        content: const Text('Email not found !'),
        action: SnackBarAction(
            label: 'RETRY', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showToast2(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent[200],
        content: const Text('You cannot add yourself as a friend !'),
        action: SnackBarAction(
            label: 'RETRY', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showToast3(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Request  Succefully sent'),
        action: SnackBarAction(
            label: 'RETRY', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                    hintText: "Enter Friend's email",
                    hintStyle: TextStyle(color: Colors.grey[400])),
                validator: (val) => val.isEmpty ? 'Enter an email ' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          color: Colors.lightGreen,
          child: Text(
            "Add friend",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            print(email);
            QuerySnapshot FutureValue =
                await DatabaseService(uid: current_user_uid)
                    .checkIfMailExist(email);
            if (FutureValue.documents.isNotEmpty) {
              String suid = FutureValue.documents[0].documentID;
              print(suid);
              if (suid == current_user_uid) {
                _showToast2(context);
              } else {
                DatabaseService(uid: current_user_uid)
                    .sendRequest(suid);
                _showToast3(context);
              }
            } else {
              _showToast1(context);
            }
          },
        ),
        SizedBox(height: 15,),
        RequestStream()
      ],
    );
  }
}
