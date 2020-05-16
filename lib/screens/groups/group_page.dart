import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/chats/message_stream.dart';
import 'package:hallo/screens/groups/groupsMessageStream.dart';


class cc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class GroupPage extends StatelessWidget {
  GroupPage({this.groupUID, this.fname});
  final String fname;
  final String groupUID;
  final msgClear = TextEditingController();
  Firestore _firestore = Firestore.instance;
  String msgText;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('groups')
          .document(groupUID)
          .collection('group_members')
          .snapshots(),
      builder: (context, snapshot) {

        if(!snapshot.hasData) {
          return Text('');
        }else{
          final listOfMems = snapshot.data.documents;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                fname,
              ),

              backgroundColor: Theme
                  .of(context)
                  .accentColor,
            ),
            body: SafeArea(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.9,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ListView(
                  children: <Widget>[
                    GroupMessages(
                      groupUID: groupUID,
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(7.0, 0, 5.0, 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                                controller: msgClear,
                                onChanged: (val) {
                                  msgText = val;
                                },
                                autocorrect: true,
                                decoration: InputDecoration(
                                  fillColor: Theme
                                      .of(context)
                                      .backgroundColor,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .canvasColor, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .focusColor, width: 2.0),
                                  ),
                                  hintText: ' Type message',
                                  //hint
                                  hintStyle: Theme
                                      .of(context)
                                      .textTheme
                                      .body2,
                                ),
                              )),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 10,
//                      height: MediaQuery
//                          .of(context)
//                          .size
//                          .height/10,

                            //padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Icon(
                                Icons.send,
                                color: Theme
                                    .of(context)
                                    .canvasColor,
                              ),
                              onPressed: () {


                                msgClear.clear();
                                print('Going to print member list:::::');
                                print('kjhkjkj $listOfMems');
                                for ( var group in listOfMems) {
                                  print(group.documentID);
                                  _firestore
                                      .collection('messages')
                                      .document(group.documentID)
                                      .collection('groups_chat')
                                      .document(groupUID)
                                      .collection('Chats')
                                      .add({
                                    'text': msgText,
                                    'time': FieldValue.serverTimestamp(),
                                    //'to': friendUID,
                                    'from': current_user_uid,
                                  });
                                }


                              },
                              color: Theme
                                  .of(context)
                                  .splashColor,
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        }


      },

    );




  }
}
