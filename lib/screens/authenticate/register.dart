import 'package:flutter/material.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/shared/loading.dart';

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
  String name = '';
  String phone='';
  String error = '';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
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
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 2.0),
                          ),

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
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 2.0),
                          ),

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
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 2.0),
                          ),

                          hintText: "Enter name",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a name '
                          : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
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
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 2.0),
                          ),

                          hintText: "Phone no",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter valid phone number'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          phone = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                        setState(() {
                          loading=true;
                        });
                        print("Email:$email");
                        print("password:$password");
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password,name,phone);
                        if (result == null) {
                          setState(() {
                            error = 'pls supple a valid mail';
                            loading=false;
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
