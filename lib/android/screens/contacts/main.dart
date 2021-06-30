import 'package:flutter/material.dart';

import './contacts.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

class ContactScreen extends StatelessWidget {
  static final String routeName = '/${CONTACTS_TITLE.toLowerCase()}';

  const ContactScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(title: CONTACTS_TITLE,),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontalVertical(screenContent: Contact(),),
      ),
    );
  }
}
