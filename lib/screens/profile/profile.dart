import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:hallo/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  String id = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  bool dpUpdated = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _image = image;
    String fileName = basename(_image.path);
    print('Image Path $_image');
  }

  Future uploadPic(BuildContext context) async {
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child('profiles/$current_user_uid');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      uploadedFileURL = fileURL;
      print("File url : $uploadedFileURL");

      DatabaseService(uid: current_user_uid).updateProfile(uploadedFileURL);
      setState(() {
        dpUpdated = false;
      });
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void _showEditProfile(String n, String s, String p, String e) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Column(
                children: <Widget>[
                  Center(child: Text("Edit Profile")),
                  SizedBox(
                    height: 10,
                  ),
                  HalloTextField(
                    text: 'DO not leave blank',
                    hint: 'Name',
                    isPassword: false,
                    onChangedText: (val) {
                      setState(() {
                        n = val;
                      });
                    },
                  ),
                  HalloTextField(
                    text: 'DO not leave blank',
                    hint: 'Status',
                    isPassword: false,
                    onChangedText: (val) {
                      setState(() {
                        s = val;
                      });
                    },
                  ),
                  HalloTextField(
                    text: 'DO not leave blank',
                    hint: 'Phone number',
                    isPassword: false,
                    onChangedText: (val) {
                      setState(() {
                        p = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  HalloButton(
                    text: 'Update',
                    onPressedBtn: () async {
                      await DatabaseService(uid: user.uid)
                          .updateUserData(n, s, p, e);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: current_user_uid).userData,
        builder: (context, snapshot) {
          if (!(snapshot.hasData)) {
            return AlertDialog(
              title: Text('Failed to Retreive Data'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Make sure you are connected to the internet'),
                    Text('Else firebase is just down sorry :('),
                    Text('Comeback later'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'okay',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/chats');
                  },
                ),
              ],
            );
          } else {
            UserData userData = snapshot.data;

            return Scaffold(
              drawer: Nav_menu(),
              backgroundColor: Theme
                  .of(context)
                  .backgroundColor,
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  _showEditProfile(userData.name, userData.status,
                      userData.phone, userData.email);
                },
                backgroundColor: Theme
                    .of(context)
                    .splashColor,
              ),
              appBar: AppBar(
                title: Text("Profile"),
                centerTitle: true,
                backgroundColor: Theme
                    .of(context)
                    .accentColor,
                elevation: 0.0,
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60.0,
                          child: ClipOval(
                            child: ModalProgressHUD(
                              inAsyncCall: dpUpdated,
                              child: new Container(
                                width: 180,
                                height: 180,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: userData.imageUrl != null
                                        ? (new NetworkImage(userData.imageUrl))
                                        : new AssetImage('images/user1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.cameraRetro,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              setState(() {
                                dpUpdated = true;
                              });
                              await getImage();

                              uploadPic(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 60,
                      color: Colors.grey[500],
                    ),
                    Text(
                      "NAME",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      userData.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "STATUS",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,

                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      userData.status,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData.email,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline,

                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '+91 ${userData.phone}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline,

                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
