import 'package:flutter/material.dart';

class AndroidHeading extends StatelessWidget {
  final String title;

  const AndroidHeading({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
