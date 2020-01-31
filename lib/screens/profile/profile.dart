import 'package:flutter/material.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Nav_menu(),
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

          });

        },
        child: Icon(
            Icons.add
        ),
        backgroundColor: Colors.grey[800],
      ),
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/'),
                radius:60.0,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.grey[500],
            ),
            Text(
              "NAME",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Sharon Joji",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 20,
                fontWeight: FontWeight.bold

              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "STATUS",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Today is the beginning of tomorrow",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color:Colors.grey[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'sharonjoji99@gmail.com',
                  style: TextStyle(
                    color:Colors.grey[400],
                    letterSpacing: 1.0,
                    fontSize:18.0,
                  ),
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
                  color:Colors.grey[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '+91 9590301135',
                  style: TextStyle(
                    color:Colors.grey[400],
                    letterSpacing: 1.0,
                    fontSize:18.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );;
  }
}
