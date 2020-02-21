import 'package:flutter/material.dart';

class HalloButton extends StatelessWidget {
  final String text;
  final onPressedBtn;

  HalloButton({this.text, this.onPressedBtn});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Theme
          .of(context)
          .buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: MaterialButton(
        onPressed: onPressedBtn,
        child: Text(
          text,
          style: Theme
              .of(context)
              .textTheme
              .button,
        ),
      ),
    );
  }
}

