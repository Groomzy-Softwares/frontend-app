import 'package:flutter/material.dart';

import './contacts.dart';
import '../../app_bar/app_bar.dart';
import '../../drawer/drawer.dart';
import '../../widgets/center/screen_center.dart';
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
        child: ScreenCenter(screenContent: Contact(),),
      ),
    );
  }
}
