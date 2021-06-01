import 'package:flutter/material.dart';

class CenterHorizontalVertical extends StatelessWidget {
  final Widget screenContent;

  CenterHorizontalVertical({@required this.screenContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [screenContent],
          ),
        ),
      ),
    );
  }
}
