import 'package:flutter/material.dart';

import '../../drawer/drawer.dart';
import '../../../common/constants/constants.dart';

class Home extends StatelessWidget {
  final Map user;

  Home({
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Holds the device dimensions
    var mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(HOME_TITLE),
        ),
        drawer: AndroidDrawer(),
        body: Container(
          height: mediaQuery.height,
          child: Center(
            child: Text('Home content centered for ${user['name']}'),
          ),
        ),
      ),
    );
  }
}
