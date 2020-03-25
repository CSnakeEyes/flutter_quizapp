import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  final bool visible;

  LoadingModal(this.visible);

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return Positioned(
        left: 0.0,
        top: 0.0,
        child: Container(
          color: Colors.black.withOpacity(0.2),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
