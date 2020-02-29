import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
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

  // here for dob
  int day = 01;
  int month = 01;
  int year = 2020;
  DateTime newDt = DateTime.now();
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
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30.0),
        child: Form(
          key: _formkey,
          child: ListView(

            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: 'icon',
                      child: Image.asset(
                        'images/hallo.png',
                        scale: 10,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
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

              ListTile(


                trailing: Container(
                  child: FlatButton(
                    onPressed: () async {
                      newDt = await showRoundedDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime
                            .now()
                            .year - 50),
                        lastDate: DateTime(DateTime
                            .now()
                            .year + 50),
                        borderRadius: 16,
                      );
                    },
                    child: Icon(
                      Icons.date_range,
                    ),
                  ),
                ),
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
                        email, password, name, phone, newDt, "");
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
          ),


    );

  }
}
