
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:hallo/models/uid.dart';

class PopUp extends StatelessWidget {
  final String friendName;
  final String imageURL;
  final String friendEmail;
  final String friendUID;

  PopUp(
      {this.friendName, this.friendEmail, this.imageURL, this.friendUID});

  Firestore _firestore = Firestore.instance;
  String first, second;
  Future dialoguebox(context) {
    return showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
          buttonOkText: Text('Accept'),
          buttonCancelText: Text('Reject'),
          buttonCancelColor: Colors.red,
          image: CircleAvatar(
            radius: 40,
            child: ClipOval(
              child: new SizedBox(
                  width: 200,
                  height: 200,
                  child: imageURL != null ? Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                  ) : Container(
                    //color: Theme.of(context).backgroundColor,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/user.png'),
                        )
                    ),
                  )
              ),
            ),
          ),

          title: Text('$friendName',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,color: Colors.white)),
          description: Text("$friendEmail",style:
          TextStyle(color: Colors.white)),
          entryAnimation: EntryAnimation.BOTTOM,

          onOkButtonPressed: () async {
            _firestore.collection('user_profiles').document(current_user_uid).collection('friends').document(friendUID).setData({
              'user_id':friendUID,

            });

            _firestore.collection('user_profiles').document(friendUID).collection('friends').document(current_user_uid).setData({
              'user_id':current_user_uid,
            });

            _firestore.collection('user_profiles').document(current_user_uid).collection('requests').document(friendUID).delete();

          },
          onCancelButtonPressed: () async {
            _firestore.collection('user_profiles').document(current_user_uid).collection('requests').document(friendUID).delete();

          },

            ));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: FlatButton(
        color: Colors.white,
        onPressed: () {
          dialoguebox(context);
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: ClipOval(
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: imageURL != null
                        ? (new NetworkImage(imageURL))
                        : new AssetImage('images/user1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          title: Text('$friendName'),
          subtitle: Text('$friendEmail'),
        ),
      ),
    );
  }
}

//
