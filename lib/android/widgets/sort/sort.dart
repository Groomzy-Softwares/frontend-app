import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AndroidSort extends StatelessWidget {
  const AndroidSort({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          FontAwesomeIcons.sortAmountDownAlt,
          size: 28,
          color: Colors.grey,
        ),
        onPressed: () {},
      ),
    );
  }
}
