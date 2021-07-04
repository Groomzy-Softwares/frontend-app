import 'package:flutter/material.dart';

import './widgets/staffs/staffs.dart';
import './widgets/services/services.dart';
import './widgets/operating_times/operating_times.dart';
import './widgets/bookings/bookings.dart';
import '../../widgets/center_horizontal/center_horizontal.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';

class Provider extends StatelessWidget {
  final int selectedIndex;
  final int providerId;

  const Provider({
    this.selectedIndex,
    this.providerId,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      AndroidCenterHorizontal(
        screenContent: Services(
          providerId: providerId,
        ),
      ),
      AndroidCenterHorizontal(
        screenContent: Bookings(
          providerId: providerId,
        ),
      ),
      AndroidCenterHorizontal(
        screenContent: Staffs(
          providerId: providerId,
        ),
      ),
      AndroidCenterHorizontal(screenContent: OperatingTimes(
        providerId: providerId,
      )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgetOptions().elementAt(selectedIndex),
    );
  }
}
