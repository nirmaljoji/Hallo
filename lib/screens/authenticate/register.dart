import 'package:flutter/material.dart';
import 'package:hallo/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 0.0,
          title: Text('Sign up to Hallo',

          style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2)),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                 //Register widget=
                  widget.toggleView();
                },
                icon: Icon(Icons.person,
                color: Colors.amberAccent[100],),
                label: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.amberAccent[100]),
                ))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Email-id",
                            hintStyle: TextStyle(color: Colors.grey[400])),
                        validator: (val) =>
                        val.isEmpty
                            ? 'Enter an email'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "password",
                            hintStyle: TextStyle(color: Colors.grey[400])),
                        validator: (val) =>
                        val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 50),

                    color: Colors.lightGreen,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        print("Email:$email");
                        print("password:$password");
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'pls supple a valid mail';
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              ),
            )));
    ;
  }
}
