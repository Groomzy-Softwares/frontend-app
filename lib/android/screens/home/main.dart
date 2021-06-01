import 'package:flutter/material.dart';

import './home.dart';
import '../../app_bar/app_bar.dart';
import '../../drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/${HOME_TITLE.toLowerCase()}';

  final Map user;

  const HomeScreen({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(
        title: HOME_TITLE,
      ),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: CenterHorizontalVertical(
          screenContent: Home(
            user: user,
          ),
        ),
      ),
    );
  }
}
