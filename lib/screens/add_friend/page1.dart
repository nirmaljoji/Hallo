import
'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Add_Friends_Page extends StatefulWidget {
  @override
  _Add_Friends_PageState createState() => _Add_Friends_PageState();
}

class _Add_Friends_PageState extends State<Add_Friends_Page> {

  String email;
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        SizedBox(height: 30,),
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
              validator: (val) =>
              val.isEmpty
                  ? 'Enter an email  '
                  : null,
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),
        ],
        ),
        SizedBox(height: 10,),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(
              vertical: 8, horizontal: 30),

          color: Colors.lightGreen,
          child: Text(
            "Add friend",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,),
          ),
          onPressed: () async {

          },
        ),
      ],
    );
  }
}
