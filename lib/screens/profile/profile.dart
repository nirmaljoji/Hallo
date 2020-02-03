import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo/services/auth.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name;
    String status;
    String phone;
    String email;

    final user =Provider.of<User>(context);

    void _showEditProfile(String n,String s, String p,String e) {

      showModalBottomSheet(

          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text("Edit Profile")),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      initialValue: n,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                          hintText: "Enter name",
                          hintStyle: TextStyle(color: Colors.grey[400])),

                      onChanged: (val) {
                        setState(() {
                          n = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(initialValue: s,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.pink, width: 2.0),
                          ),
                          hintText: "Enter Status",
                          hintStyle: TextStyle(color: Colors.grey[400])),

                      onChanged: (val) {
                        setState(() {
                          s = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      initialValue: p,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.pink, width: 2.0),
                          ),
                          hintText: "Enter Phone no.",
                          hintStyle: TextStyle(color: Colors.grey[400])),

                      onChanged: (val) {
                        setState(() {
                          p = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),

                    color: Colors.lightGreen,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,),
                    ),
                    onPressed: () async {

                      await DatabaseService(uid: user.uid).updateUserData(n, s, p, e);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }


    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: current_user_uid).userData ,
        builder: (context, snapshot)  {

          if (!(snapshot.hasData)) {




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
                  child: Text(
                    'okay',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/chats');
                  },
                ),
              ],
            );
          } else {

            UserData userData = snapshot.data;
            return Scaffold(
              drawer: Nav_menu(),
              backgroundColor: Colors.grey[900],
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  _showEditProfile(userData.name,userData.status,userData.phone,userData.email);
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
                      userData.name,
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
                      userData.status,
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
                          userData.email,
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
                          '+91 ${userData.phone}',
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
