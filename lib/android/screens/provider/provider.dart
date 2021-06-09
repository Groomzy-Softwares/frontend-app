import 'package:flutter/material.dart';
import 'package:groomzy/android/widgets/center_horizontal_vertical/center_horizontal_vertical.dart';

import './widgets/business.dart';
import './widgets/operating_times.dart';

class Provider extends StatelessWidget {
  final int selectedIndex;

  const Provider({
    this.selectedIndex,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      Business(),
      OperatingTimes(),
      Container(child: Text('3')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgetOptions().elementAt(selectedIndex),
    );
  }
}
