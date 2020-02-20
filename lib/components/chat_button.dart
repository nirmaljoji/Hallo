import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  final String friendName;
  final String imageURL;
  var onPressed;

  ChatButton({this.friendName, this.onPressed, this.imageURL});

  @override
  Widget build(BuildContext context) {
    print('chat button $friendName');
    return Material(
      elevation: 2.0,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 500.0,
        height: 70.0,
        child: ListTile(
          leading: imageURL!=null?Image.network(
            imageURL,
            fit: BoxFit.cover ,
          ):SizedBox(width: 1.0),
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
