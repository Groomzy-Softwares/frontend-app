import 'package:flutter/material.dart';

import './styles.dart';
import './drawer_item/item.dart';
import './drawer_item/item_header.dart';
import '../screens/signin/main.dart';
import '../screens/signup/main.dart';
import '../screens/home/main.dart';
import '../screens/about/main.dart';
import '../screens/contacts/main.dart';
import '../../common/types/types.dart';
import '../../common/constants/constants.dart';

class AndroidDrawer extends StatefulWidget {
  @override
  _AndroidDrawerState createState() => _AndroidDrawerState();
}

class _AndroidDrawerState extends State<AndroidDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerItemHeader(
            name: 'Groomzy',
            email: 'info@groomzy.co.za',
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerItem(
                  icon: Icons.home,
                  title: HOME_TITLE,
                  navigateTo: HomeScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                DrawerItem(
                  icon: Icons.edit,
                  title: 'Edit profile',
                ),
                Divider(),
                DrawerItem(
                  icon: Icons.info,
                  title: ABOUT_TITLE,
                  navigateTo: AboutScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                DrawerItem(
                  icon: Icons.contact_page,
                  title: CONTACTS_TITLE,
                  navigateTo: ContactScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                Divider(),
                DrawerItem(
                  icon: Icons.login,
                  title: SIGNIN_TITLE,
                  navigateTo: SignInScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                DrawerItem(
                  icon: Icons.person_add,
                  title: SIGNUP_TITLE,
                  navigateTo: SignUpScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                DrawerItem(
                  icon: Icons.logout,
                  title: 'Sign out',
                ),
                Divider(),
                DrawerItem(
                  icon: Icons.policy,
                  title: 'Ts & Cs',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Copyright © 2020 Groomzy (Pty, Ltd)',
                    style: DrawerStyles().footerTextStyle,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'v0.0.1',
                    style: DrawerStyles().footerTextStyle
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
