import 'package:flutter/material.dart';

class HalloTextField extends StatelessWidget {
  final String text, hint;
  final onChangedText;
  final bool isPassword;

  HalloTextField({this.text, this.hint, this.onChangedText, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: TextFormField(
        onChanged: onChangedText,
        validator: (val) =>
        (val.isEmpty || val.length < 6)
            ? text //text
            : null,
        style: Theme
            .of(context)
            .textTheme
            .body2,
        decoration: InputDecoration(
          fillColor: Theme
              .of(context)
              .canvasColor,
          filled: true,
          contentPadding: EdgeInsets.all(12.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .canvasColor, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .focusColor, width: 2.0),
          ),

          hintText: hint,
          //hint
          hintStyle: Theme
              .of(context)
              .textTheme
              .body2,
        ),

        obscureText: this.isPassword,
      ),
    );
  }
}
