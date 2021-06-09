import 'dart:convert';

import 'package:flutter/material.dart';

import './explorer.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';


class ExploreScreen extends StatelessWidget {
  static final String routeName = '/${EXPLORER_TITLE.toLowerCase()}';

  const ExploreScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(
        title: HOME_TITLE,
      ),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontalVertical(
          showSearch: true,
          screenContent: Explore(),
        ),
      ),
    );
  }
}
