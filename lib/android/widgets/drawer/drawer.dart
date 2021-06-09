import 'dart:convert';

import 'package:flutter/material.dart';

import './styles.dart';
import './drawer_item/item.dart';
import './drawer_item/item_header.dart';
import '../../screens/signin/main.dart';
import '../../screens/signup/main.dart';
import '../../screens/about/main.dart';
import '../../screens/contacts/main.dart';
import '../../screens/explorer/main.dart';
import '../../../common/types/types.dart';
import '../../../common/constants/constants.dart';

import '../../utils/utils.dart';


import '../../../api/utils/utils.dart';

class AndroidDrawer extends StatefulWidget {
  @override
  _AndroidDrawerState createState() => _AndroidDrawerState();
}

class _AndroidDrawerState extends State<AndroidDrawer> {
  Map _user;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    AuthUtil().getUser().then((res) {
      if (res != null) {
        if (mounted) {
          setState(() {
            _user = jsonDecode(res);
          });
        }
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _user = null;
        });
      }
    });
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(_user);
    return Drawer(
      child: Column(
        children: <Widget>[
          AndroidDrawerItemHeader(
            name: _user != null ? _user['fullName'] : 'Groomzy',
            email: _user != null ? _user['email'] : 'info@groomzy.co.za',
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                AndroidDrawerItem(
                  icon: Icons.home_outlined,
                  title: HOME_TITLE,
                  navigateTo: Utils().navigateToHome(_user != null ? _user['role'] : ''),
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                AndroidDrawerItem(
                  icon: Icons.info_outline,
                  title: ABOUT_TITLE,
                  navigateTo: AboutScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                AndroidDrawerItem(
                  icon: Icons.contact_page_outlined,
                  title: CONTACTS_TITLE,
                  navigateTo: ContactScreen.routeName,
                  navigateType: NavigatorNamedType.POP_AND_PUSH,
                ),
                Divider(),
                if (_user != null)
                  AndroidDrawerItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit profile',
                  ),
                if (_user == null)
                  AndroidDrawerItem(
                    icon: Icons.login_outlined,
                    title: SIGNIN_TITLE,
                    navigateTo: SignInScreen.routeName,
                    navigateType: NavigatorNamedType.POP_AND_PUSH,
                  ),
                if (_user == null)
                  AndroidDrawerItem(
                    icon: Icons.person_add_outlined,
                    title: SIGNUP_TITLE,
                    navigateTo: SignUpScreen.routeName,
                    navigateType: NavigatorNamedType.POP_AND_PUSH,
                  ),
                if (_user != null)
                  AndroidDrawerItem(
                    icon: Icons.logout_outlined,
                    title: 'Sign out',
                    navigateTo: ExploreScreen.routeName,
                  ),
                Divider(),
                AndroidDrawerItem(
                  icon: Icons.policy_outlined,
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
                  child: Text('v0.0.1', style: DrawerStyles().footerTextStyle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
