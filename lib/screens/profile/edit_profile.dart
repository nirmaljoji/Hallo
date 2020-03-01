import 'package:flutter/material.dart';


class Edit_Profile extends StatefulWidget {

  String id = '/edit_profile';

  @override
  _Edit_ProfileState createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 160,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 125,
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .accentColor
                      .withOpacity(50.0),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Theme
                        .of(context)
                        .backgroundColor, spreadRadius: 5)
                  ]),
              child: Column(
                  children: []
              ),
            )

          ]
      ),
    );
  }
}

