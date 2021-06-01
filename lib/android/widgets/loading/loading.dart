import 'package:flutter/material.dart';

import '../center_horizontal_vertical/center_horizontal_vertical.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenterHorizontalVertical(
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
