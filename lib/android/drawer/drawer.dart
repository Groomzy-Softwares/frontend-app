import 'package:flutter/material.dart';

import './styles.dart';
import './drawer_item/item.dart';
import './drawer_item/item_header.dart';

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
                  title: 'Home',
                ),
                DrawerItem(
                  icon: Icons.edit,
                  title: 'Edit profile',
                ),
                Divider(),
                DrawerItem(
                  icon: Icons.info,
                  title: 'About',
                ),
                DrawerItem(
                  icon: Icons.contact_page,
                  title: 'Contacts',
                ),
                Divider(),
                DrawerItem(
                  icon: Icons.login,
                  title: 'Sign in',
                ),
                DrawerItem(
                  icon: Icons.person_add,
                  title: 'Sign up',
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
