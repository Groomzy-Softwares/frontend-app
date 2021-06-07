import 'package:flutter/material.dart';

class ProviderHome extends StatelessWidget {
  final Map user;

  const ProviderHome({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Text('Provider!'),
    );
  }
}
