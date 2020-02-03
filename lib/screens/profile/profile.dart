import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {



    void _showEditProfile() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Column(
                children: <Widget>[


                ],
              ),
            );
          });
    }



    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService().getProfileData(current_user_uid),
        builder: (context, snapshot) {

          print(snapshot.data.exists);
          if (!(snapshot.data.exists)) {
            return AlertDialog(
              title: Text('Failed to Retreive Data'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Make sure you are connected to the internet'),
                    Text('Else firebase is just down sorry :('),
                    Text('Comeback later'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('okay',
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                  onPressed: () {

                    Navigator.pushReplacementNamed(context, '/chats');
                  },
                ),
              ],
            );
          } else {
            return Scaffold(
              drawer: Nav_menu(),
              backgroundColor: Colors.grey[900],
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  _showEditProfile();
                },
                backgroundColor: Colors.grey[800],
              ),
              appBar: AppBar(
                title: Text("Profile"),
                centerTitle: true,
                backgroundColor: Colors.grey[850],
                elevation: 0.0,
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/'),
                        radius: 60.0,
                      ),
                    ),
                    Divider(
                      height: 60,
                      color: Colors.grey[500],
                    ),
                    Text(
                      "NAME",
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${snapshot.data['user_name']}",
                      style: TextStyle(
                          color: Colors.amberAccent[200],
                          letterSpacing: 2.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "STATUS",
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${snapshot.data['user_status']}",
                      style: TextStyle(
                          color: Colors.amberAccent[200],
                          letterSpacing: 2.0,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${snapshot.data['user_email']}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '+91 ${snapshot.data['user_phone']}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
