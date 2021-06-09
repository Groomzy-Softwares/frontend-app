import 'package:flutter/material.dart';
import './widgets/services.dart';

class ProviderTrading extends StatelessWidget {
  final int selectedIndex;

  const ProviderTrading({
    this.selectedIndex,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      Services(),
      Container(child: Text('2')),
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
