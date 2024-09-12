import 'package:flutter/material.dart';

class AndroidCenterHorizontalVertical extends StatelessWidget {
  final Widget screenContent;

  AndroidCenterHorizontalVertical({
    @required this.screenContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: screenContent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
