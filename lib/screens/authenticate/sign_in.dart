import 'package:flutter/material.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/shared/hallo_theme_data.dart';
import 'package:hallo/shared/loading.dart';

class SignIn extends StatefulWidget {
  String id = '/signin';

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  HalloThemeData data = new HalloThemeData();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .accentColor,
          elevation: 0.0,
          title: Text(
            data.hallo,
            style: Theme
                .of(context)
                .textTheme
                .title,
          ),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 5.0),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30.0
            ),
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  Container(
                    //margin: const EdgeInsets.fromLTRB(0, 0, 0, 100.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/hallo.png',
                          scale: 5,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          data.hallo,
                          style: Theme
                              .of(context)
                              .textTheme
                              .title,
                        ),

                      ],
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      HalloTextField(
                        text: "Enter email",
                        hint: 'Email',
                        onChangedText: (val) {
                          setState(() {
                            email = val; //String mail
                          });
                        },
                        isPassword: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      HalloTextField(
                        text:
                        "Enter password that is atleaat 6 characters long",
                        hint: 'Password',
                        onChangedText: (val) {
                          setState(() {
                            password = val; //String mail
                          });
                        },
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      HalloButton(
                        color1: data.btnColor,
                        color2: data.cardColor,
                        text: 'Sign In',
                        onPressedBtn: () async {
                          print("Email:$email");
                          print("password:$password");

                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Could Not Sign in with Credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      HalloButton(
                        color1: data.primaryColorDark,
                        color2: data.primaryColorLight,
                        text: 'Register',
                        onPressedBtn: () {
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),

                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              ),
            )));
  }
}
