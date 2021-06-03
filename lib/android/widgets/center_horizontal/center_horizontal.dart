import 'package:flutter/material.dart';

class AndroidCenterHorizontal extends StatelessWidget {
  final Widget screenContent;

  AndroidCenterHorizontal({@required this.screenContent});

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
