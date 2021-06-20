import 'package:flutter/material.dart';

import 'widgets/bookings.dart';
import '../explorer/explorer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical_expanded.dart';

class Client extends StatelessWidget {
  final int selectedIndex;

  const Client({
    this.selectedIndex,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      AndroidCenterHorizontalVerticalExpanded(
        showSearch: true,
        screenContent: Explore(),
      ),
      AndroidCenterHorizontalVertical(
        screenContent: Bookings(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgetOptions().elementAt(selectedIndex),
    );
  }
}
