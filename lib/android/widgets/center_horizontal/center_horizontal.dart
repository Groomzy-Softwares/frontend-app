import 'package:flutter/material.dart';

class CenterHorizontal extends StatelessWidget {
  final Widget screenContent;

  CenterHorizontal({@required this.screenContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [screenContent],
          ),
        ),
      ),
    );
  }
}
