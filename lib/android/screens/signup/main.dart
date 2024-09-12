import 'package:flutter/material.dart';

import './signup.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

class SignUpScreen extends StatelessWidget {
  static final String routeName = '/${SIGNUP_TITLE.toLowerCase()}';

  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(title: SIGNUP_TITLE,),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontalVertical(screenContent: SignUp(),),
      ),
    );
  }
}
