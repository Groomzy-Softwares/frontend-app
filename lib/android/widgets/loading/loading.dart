import 'package:flutter/material.dart';

import '../center/screen_center.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenCenter(
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
