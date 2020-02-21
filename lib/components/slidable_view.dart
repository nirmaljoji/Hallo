import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableView extends StatelessWidget {


  final String friendName;
  final String imageURL;
  final String friendEmail;


  SlidableView({this.friendName, this.friendEmail, this.imageURL});


  @override
  Widget build(BuildContext context) {
    return Slidable(
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
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red[400],
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}
//