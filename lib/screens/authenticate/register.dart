import 'package:flutter/material.dart';
import 'package:hallo/components/hallo_button.dart';
import 'package:hallo/components/hallo_text_field.dart';
import 'package:hallo/services/auth.dart';
import 'package:hallo/shared/hallo_theme_data.dart';
import 'package:hallo/shared/loading.dart';


class Register extends StatefulWidget {
  String id = '/register';

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
  String phone = '';
  String error = '';
  bool loading = false;


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
          title: Text('Sign up to Hallo',
              style:
              TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                HalloTextField(
                  text: 'Enter an email',
                  hint: "Email-id",
                  onChangedText: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  isPassword: false,
                ),
                SizedBox(
                  height: 10,
                ),
                HalloTextField(
                  text: 'Password must be atleats 6 characters long',
                  hint: 'Password',
                  onChangedText: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  isPassword: true,
                ),
                SizedBox(
                  height: 10,
                ),
                HalloTextField(
                  text: 'Name muxst not be empty',
                  hint: 'Name',
                  onChangedText: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  isPassword: false,
                ),
                SizedBox(
                  height: 10,
                ),
                HalloTextField(
                  text: 'Enter valid phone number',
                  hint: 'Phone Number',
                  onChangedText: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                  isPassword: false,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                HalloButton(
                  color1: data.btnColor,
                  color2: data.cardColor,
                  text: 'Register',
                  onPressedBtn: () async {
                    if (_formkey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result =
                      await _auth.registerWithEmailAndPassword(
                          email, password, name, phone);
                      if (result == null) {
                        setState(() {
                          error = 'pls supply a valid mail';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                HalloButton(
                  color1: data.primaryColorDark,
                  color2: data.primaryColorLight,
                  text: 'Sign in',
                  onPressedBtn: () {
                    //Register widget=
                    widget.toggleView();
                  },
                ),
              ],
            ),
          ),
        )

    );

  }
}
