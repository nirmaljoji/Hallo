import 'package:flutter/material.dart';
import 'package:hallo/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //Text fiels states
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
          title: Text("Sign in to Hallo",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person, color: Colors.amberAccent[100]),
                label: Text(
                  "Register",
                  style: TextStyle(color: Colors.amberAccent[100]),
                ))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formkey,
              child: Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 150.0),
                      child: Image.asset(
                        'images/hallo.png',
                        scale: 5,
                      ),
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
                          validator: (val) =>
                          val.isEmpty
                              ? 'Enter an email'
                              : null,
                          style: TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                            hintText: "Email-id",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),


                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                      ),
                    ),
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
                          validator: (val) =>
                          val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          style: TextStyle(color: Colors.white),
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
                        "Sign in",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      onPressed: () async {
                        print("Email:$email");
                        print("password:$password");

                        if (_formkey.currentState.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Could Not Sign in with Credentials';
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
              ),
            )));
  }
}
