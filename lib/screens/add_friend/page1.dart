import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/add_friend/request_stream.dart';
import 'package:hallo/services/database.dart';
import 'package:hallo/shared/hallo_theme_data.dart';

class Add_Friends_Page extends StatefulWidget {
  @override
  _Add_Friends_PageState createState() => _Add_Friends_PageState();
}

class _Add_Friends_PageState extends State<Add_Friends_Page> {

  HalloThemeData data = new HalloThemeData();

  void _showToast1(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[300],
        content: const Text('Email not found!'),
        action: SnackBarAction(
            label: 'RETRY', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showToast2(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[300],
        content: const Text('You cannot add yourself as a friend!'),
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
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Container(
          margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
          child: HalloTextField(
            hint: "Enter friend's email",
            text: 'This user is not registerned on Hallo',
            isPassword: false,
            inputType: 1,
            onChangedText: (val) {
              setState(() {
                email = val;
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
          text: 'Add friend',
          onPressedBtn: () async {
            if(email==null){
              _showToast1(context);
            }
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
