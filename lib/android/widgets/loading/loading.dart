import 'package:flutter/material.dart';

import '../center_horizontal_vertical/center_horizontal_vertical.dart';

class AndroidLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AndroidCenterHorizontalVertical(
      screenContent: Column(
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ),
          Text('Loading...'),
        ],
      ),
    );
  }
}
