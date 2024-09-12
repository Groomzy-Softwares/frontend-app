import 'package:flutter/material.dart';

class AndroidCenterHorizontal extends StatelessWidget {
  final Widget screenContent;

  AndroidCenterHorizontal({@required this.screenContent});

  @override
  Widget build(BuildContext context) {
    return Container(
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
