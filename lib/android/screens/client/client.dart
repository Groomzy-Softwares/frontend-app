import 'package:flutter/material.dart';
import './widgets/services.dart';

class Client extends StatelessWidget {
  final int selectedIndex;

  const Client({
    this.selectedIndex,
    Key key,
  }) : super(key: key);

  List<Widget> _widgetOptions() {
    return <Widget>[
      ProviderServices(),
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
