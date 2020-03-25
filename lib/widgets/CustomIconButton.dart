import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final bool contrast;
  final Function onPressed;

  CustomIconButton({this.icon, this.contrast: false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100.0),
      color: contrast ? Color(0xFFFFC107) : Colors.transparent,
      elevation: contrast ? 5.0 : 0.0,
      child: IconButton(
        icon: Icon(icon),
        color: contrast ? Colors.white : Color(0xFFFFC107),
        onPressed: onPressed,
      ),
    );
  }
}
