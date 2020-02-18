import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  String friendName;
  var onPressed;

  ChatButton({this.friendName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 500.0,
        height: 70.0,
        child: ListTile(
          //leading: Image.network('https://www.facebook.com/photo.php?fbid=1244009335781317&set=a.111456479036614&type=3&theater'),
          title: Text(
            friendName,
            style: TextStyle(
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
