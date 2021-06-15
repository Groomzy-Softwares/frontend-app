import 'package:flutter/material.dart';

import './widgets/services.dart';
import './widgets/operating_times.dart';
import './widgets/bookings.dart';

class Provider extends StatelessWidget {
  final int selectedIndex;

  const Provider({
    this.selectedIndex,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      Services(),
      Bookings(),
      OperatingTimes(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgetOptions().elementAt(selectedIndex),
    );
  }
}
