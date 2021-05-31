import 'package:flutter/material.dart';

class DrawerItemHeader extends StatelessWidget {
  final String name;
  final String email;

  const DrawerItemHeader({this.name, this.email, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      accountName: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      accountEmail: Text(email),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
