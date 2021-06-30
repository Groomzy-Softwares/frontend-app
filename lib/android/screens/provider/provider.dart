import 'package:flutter/material.dart';

import './widgets/staffs/staffs.dart';
import './widgets/services/services.dart';
import './widgets/operating_times/operating_times.dart';
import './widgets/bookings/bookings.dart';
import '../../widgets/center_horizontal/center_horizontal.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';


class Provider extends StatelessWidget {
  final int selectedIndex;

  const Provider({
    this.selectedIndex,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      AndroidCenterHorizontal(screenContent: Services(),),
      AndroidCenterHorizontal(screenContent: Bookings()),
      AndroidCenterHorizontal(screenContent: Staffs()),
      AndroidCenterHorizontalVertical(screenContent: OperatingTimes()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgetOptions().elementAt(selectedIndex),
    );
  }
}
