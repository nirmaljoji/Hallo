import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/shared/loading.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/services/auth.dart';


class ForgotPwd extends StatefulWidget {

  String id = '/ForgotPwd';
  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {

  FirebaseAuth _FirebaseAuth=FirebaseAuth.instance;
  String email;

  bool loading = false;

  @override
  Widget build(BuildContext context) {


    void _showToast(BuildContext context) {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          backgroundColor: Theme
              .of(context)
              .splashColor,
          content: const Text('Error email not foung !'),
          action: SnackBarAction(
              label: 'RETRY', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    }


    return HalloTextField(
      text:"" ,
      hint: "Enter email",
      isPassword: false,
      onChangedText: (value){
        setState(() async{
          email=value;
          QuerySnapshot FutureValue =
              await DatabaseService(uid: current_user_uid)
              .checkIfMailExist(email);
           if(FutureValue.documents.isNotEmpty){
             _FirebaseAuth.sendPasswordResetEmail(email: email);

             Navigator.pushNamed(context, '/login');



           }
           else{
             _showToast(context);
           }
        });

      },
    );

  }
}
