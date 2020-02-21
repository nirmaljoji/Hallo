import 'package:flutter/material.dart';

class HalloTextField extends StatelessWidget {
  final String text, hint;
  final onChangedText;
  final bool isPassword;

  HalloTextField({this.text, this.hint, this.onChangedText, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 2.0,
        ),
      ),
      child: TextFormField(
        onChanged: onChangedText,
        validator: (val) => val.isEmpty
            ? text //text
            : null,
        style: TextStyle(
          color: Colors.black,
        ),
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

          hintText: hint,
          //hint
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        obscureText: this.isPassword,
      ),
    );
  }
}
