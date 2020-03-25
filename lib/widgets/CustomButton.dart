import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
  final String text;
  final bool contained;
  final Function onPressed;

  CustomButton({this.text, this.contained: true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: (contained) ? Color(0xffffc40f) : Colors.white,
      elevation: 5.0,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
        side: BorderSide(color: Color(0xffffc40f), width: 2.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style.copyWith(
          color: (contained) ? Colors.white : Color(0xffffc40f),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
