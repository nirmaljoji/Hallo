import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

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
            backgroundColor: Colors.indigoAccent,
            child: Text(''),
            foregroundColor: Colors.white,
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
          onTap: (){},
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