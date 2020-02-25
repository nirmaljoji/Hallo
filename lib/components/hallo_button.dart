import 'package:flutter/material.dart';

class HalloButton extends StatefulWidget {
  final String text;
  final onPressedBtn;
  final Color color1;
  final Color color2;

  HalloButton({this.text, this.onPressedBtn, this.color1, this.color2});

  @override
  _HalloButtonState createState() => _HalloButtonState();
}

class _HalloButtonState extends State<HalloButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            // 10% of the width, so there are ten blinds.
            colors: [widget.color1, widget.color2],
            tileMode: TileMode.repeated,
          ),
        ),
        child: MaterialButton(
          onPressed: widget.onPressedBtn,
          minWidth: 150.0,
          height: 42.0,
          child: Text(
            widget.text,
            style: Theme
                .of(context)
                .textTheme
                .button,
          ),
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

