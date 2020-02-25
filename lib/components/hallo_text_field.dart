import 'package:flutter/material.dart';

class HalloTextField extends StatefulWidget {
  final String text, hint;
  final onChangedText;
  final bool isPassword;

  HalloTextField({this.text, this.hint, this.onChangedText, this.isPassword});

  @override
  _HalloTextFieldState createState() => _HalloTextFieldState();
}

class _HalloTextFieldState extends State<HalloTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: widget.onChangedText,
        validator: (val) =>
        (val.isEmpty || val.length < 6)
            ? widget.text //text
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

          hintText: widget.hint,
          //hint
          hintStyle: Theme
              .of(context)
              .textTheme
              .body2,
        ),

        obscureText: this.widget.isPassword,
      ),
    );
  }
}
