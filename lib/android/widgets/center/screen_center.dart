import 'package:flutter/material.dart';

class ScreenCenter extends StatelessWidget {
  final Widget screenContent;

  ScreenCenter({@required this.screenContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
