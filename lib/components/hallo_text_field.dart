import 'package:flutter/material.dart';

class HalloTextField extends StatefulWidget {
  final String text, hint;
  final onChangedText;
  final int inputType;  //1 - email, 2 - password, 3 - name, 4 - ph number
  final bool isPassword;

  HalloTextField({this.text, this.hint, this.onChangedText, this.inputType , this.isPassword});

  @override
  _HalloTextFieldState createState() => _HalloTextFieldState();
}

class _HalloTextFieldState extends State<HalloTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(

        onChanged: widget.onChangedText,
        validator: (val)
        {
          String pattern = r'(^[0-9]{10}$)';
          RegExp regExp = new RegExp(pattern);
          if(widget.inputType == 1 &&(val.isEmpty))
            return widget.text;
          else if(widget.inputType == 2 && (val.isEmpty || val.length < 8))
            return widget.text;
          else if(widget.inputType == 3 && (val.isEmpty || val.length < 2))
            return widget.text;
          else if(widget.inputType == 4 && (val.isEmpty || !regExp.hasMatch(val)))
            return widget.text;
          else
            return null;
        },
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
