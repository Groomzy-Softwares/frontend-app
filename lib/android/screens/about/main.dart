import 'package:flutter/material.dart';

import './about.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  static final String routeName = '/${ABOUT_TITLE.toLowerCase()}';

  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(title: ABOUT_TITLE,),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontalVertical(screenContent: About(),),
      ),
    );
  }
}
