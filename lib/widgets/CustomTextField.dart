import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
  final bool obscure;
  final String hintText;
  final Function onChanged;
  final TextEditingController inputController;

  CustomTextField(
      {this.obscure, this.hintText, this.onChanged, this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      style: style,
      onChanged: onChanged,
      controller: inputController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }
}
