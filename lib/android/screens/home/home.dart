import 'dart:convert';

import 'package:flutter/material.dart';

import './explore_home.dart';
import './client_home.dart';
import './provider_home.dart';

class Home extends StatelessWidget {
  final Map user;
  const Home({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      if (user['role'] == 'Client') {
        return ClientHome(
          user: user,
        );
      } else if (user['role'] == 'Provider') {
        return ProviderHome(user: user);
      }
      return ExploreHome();
    }
    return ExploreHome();
  }
}
