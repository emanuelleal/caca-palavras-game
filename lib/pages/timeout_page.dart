import 'package:flutter/material.dart';

class TimeoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text('Tempo esgotado!'),
        decoration: new BoxDecoration(
          color: Colors.red,
        ));
  }
}
