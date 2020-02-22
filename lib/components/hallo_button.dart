import 'package:flutter/material.dart';

class HalloButton extends StatefulWidget {
  final String text;
  final onPressedBtn;

  HalloButton({this.text, this.onPressedBtn});

  @override
  _HalloButtonState createState() => _HalloButtonState();
}

class _HalloButtonState extends State<HalloButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme
          .of(context)
          .buttonColor,
      child: MaterialButton(
        onPressed: widget.onPressedBtn,
        minWidth: 100.0,
        height: 42.0,
        child: Text(
          widget.text,
          style: Theme
              .of(context)
              .textTheme
              .button,
        ),
      ),
    );
  }
}
/*
RaisedButton(
      elevation: 5.0,
      color: Theme
          .of(context)
          .buttonColor,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: onPressedBtn,
      child: Text(
        text,
        style: Theme
            .of(context)
            .textTheme
            .button,
      ),
    );
  }
 */

