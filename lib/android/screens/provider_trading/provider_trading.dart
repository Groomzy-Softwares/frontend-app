import 'package:flutter/material.dart';

import './widgets/services.dart';
import './widgets/details.dart';
import './widgets/reviews.dart';

class ProviderTrading extends StatelessWidget {
  final int selectedIndex;
  final int providerId;
  final List services;
  final List staffs;

  const ProviderTrading({
    this.selectedIndex,
    this.providerId,
    this.services,
    this.staffs,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      Services(
        providerId: providerId,
        services: services,
        staffs: staffs,
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
