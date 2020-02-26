import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/shared/hallo_theme_data.dart';


class ForgotPwd extends StatefulWidget {

  String id = '/ForgotPwd';
  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {

  FirebaseAuth _FirebaseAuth=FirebaseAuth.instance;
  String email;

  bool loading = false;

  // user defined function
  void _showDialog(bool state) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Email Verification"),
          content: state==false ? new Text("Failed ! , please provide a valid email") : new Text(" Successull ! Check your email to reset password"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    HalloThemeData data = new HalloThemeData();


    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .accentColor,
        elevation: 0.0,
        title: Text(
          data.hallo,
          style: Theme
              .of(context)
              .textTheme
              .title,
        ),
      ),




      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30.0),
            child: HalloTextField(
              text: "",
              hint: "Enter email",
              isPassword: false,
              onChangedText: (value) {
                setState(() async {
                  email = value;

                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          HalloButton(
            color1: data.btnColor,
            color2: data.cardColor,
            text: "Send Verification",
            onPressedBtn: () async {

              QuerySnapshot FutureValue =
                  await DatabaseService(uid: current_user_uid)
                  .checkIfMailExist(email);
              if (FutureValue.documents.isNotEmpty) {
                _FirebaseAuth.sendPasswordResetEmail(email: email);


                _showDialog(true);

              }
              else {
                _showDialog(false);
              }

            },
          )




        ],
      ),
    );

  }
}
