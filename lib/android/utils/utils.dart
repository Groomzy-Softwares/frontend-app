import 'package:flutter/material.dart';

import '../screens/client/main.dart';
import '../screens/explorer/main.dart';
import '../screens/provider/main.dart';

class Utils {
  Widget homeScreen(String role) {
    if (role == 'Client') {
      return ClientScreen();
    } else if (role == 'Provider') {
      return ProviderScreen();
    }
    return ExploreScreen();
  }

  String navigateToHome(String role) {
    if (role == 'Client') {
      return ClientScreen.routeName;
    } else if (role == 'Provider') {
      return ProviderScreen.routeName;
    }
    return ExploreScreen.routeName;
  }
}