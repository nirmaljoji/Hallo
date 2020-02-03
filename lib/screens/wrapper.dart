//Listen to Stream of and check for whether  user has logged in or logged out

import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hallo/screens/home/home.dart';
import 'package:hallo/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    if (user == null) {
      return Authenticate();
    } else {
      print(user.uid);
      current_user_uid=user.uid;
      return Home();
    }
  }
}


