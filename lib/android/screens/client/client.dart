import 'package:flutter/material.dart';

import 'widgets/bookings.dart';
import '../explorer/explorer.dart';
import '../../widgets/center_horizontal/center_horizontal_expanded.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical_expanded.dart';

class Client extends StatelessWidget {
  final int selectedIndex;
  final int clientId;

  const Client({
    this.selectedIndex,
    this.clientId,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      AndroidCenterHorizontalVerticalExpanded(
        screenContent: Explore(),
      ),
      AndroidCenterHorizontalExpanded(
        screenContent: Bookings(clientId: clientId),
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
