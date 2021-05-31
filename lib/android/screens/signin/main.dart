import 'package:flutter/material.dart';

import './signin.dart';
import '../../app_bar/app_bar.dart';
import '../../drawer/drawer.dart';
import '../../widgets/center/screen_center.dart';
import '../../../common/constants/constants.dart';

class SignInScreen extends StatelessWidget {
  static final String routeName = '/${SIGNIN_TITLE.toLowerCase()}';

  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(title: SIGNIN_TITLE,),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: ScreenCenter(screenContent: SignIn(),),
      ),
    );
  }
}
