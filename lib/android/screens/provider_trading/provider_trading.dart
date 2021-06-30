import 'package:flutter/material.dart';

import './widgets/services.dart';
import './widgets/details.dart';
import './widgets/reviews.dart';

class ProviderTrading extends StatelessWidget {
  final int selectedIndex;
  final int providerId;
  final int minimumDuration;
  final List services;
  final List staffs;
  final List dayTimes;

  const ProviderTrading({
    this.selectedIndex,
    this.providerId,
    this.services,
    this.staffs,
    this.dayTimes,
    this.minimumDuration,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      Services(
        providerId: providerId,
        services: services,
        staffs: staffs,
        dayTimes: dayTimes,
        minimumDuration: minimumDuration,
      ),
      Details(),
      Reviews(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgetOptions().elementAt(selectedIndex),
    );
  }
}
