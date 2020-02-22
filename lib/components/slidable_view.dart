import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/services/database.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class SlidableView extends StatelessWidget {


  final String friendName;
  final String imageURL;
  final String friendEmail;
  final String friendUID;


  SlidableView({this.friendName, this.friendEmail, this.imageURL,this.friendUID});

  Firestore _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: ClipOval(

                child: new Container(

                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: imageURL != null
                          ? (new NetworkImage(
                          imageURL))
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

        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Accept',
            color: Colors.blue,
            icon: Icons.favorite,
            onTap: ()  async {

                 _firestore.collection('user_profiles').document(current_user_uid).collection('friends').document(friendUID).setData({
                   'user_id': friendUID,
                 });
                 _firestore.collection('user_profiles').document(friendUID).collection('friends').document(current_user_uid).setData({
                   'user_id': current_user_uid,
                 });
                 print("complete");

                 _firestore.collection('user_profiles').document(current_user_uid).collection('requests').document(friendUID).delete();

            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red[400],
            icon: Icons.delete,
            onTap: () {

              _firestore.collection('user_profiles').document(current_user_uid).collection('requests').document(friendUID).delete();

            },
          ),
        ],
      ),
    );
  }
}
//