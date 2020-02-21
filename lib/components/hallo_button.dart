import 'package:flutter/material.dart';

class HalloButton extends StatelessWidget {
  final String text;
  final onPressedBtn;

  HalloButton({this.text, this.onPressedBtn});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
      color: Theme.of(context).cardColor,
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: onPressedBtn,
    );
  }
}
