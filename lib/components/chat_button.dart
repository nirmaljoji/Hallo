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
      color: Colors.grey,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 500.0,
        height: 70.0,
        child: ListTile(
          contentPadding: EdgeInsets.all(4.0),
          leading: imageURL != null ? CircleAvatar(
            backgroundImage: AssetImage('assets/'),
            radius: 30.0,
            child: ClipOval(
              child: new SizedBox(
                  width: 180,
                  height: 180,
                  child: imageURL != null ? Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                  ) : Container(
                    color: Colors.amber,
                  )
              ),
            ),
          ) : CircleAvatar(
            backgroundImage: AssetImage('images/user.png'),
            backgroundColor: Colors.white54,
            radius: 30.0,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                friendName,
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),

        ),
      ),
    );
  }
}
