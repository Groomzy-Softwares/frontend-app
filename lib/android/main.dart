import 'dart:convert';

import 'package:flutter/material.dart';

import './screens/signin/main.dart';
import './screens/signup/main.dart';
import './screens/home/main.dart';
import './screens/about/main.dart';
import './screens/contacts/main.dart';
import './screens/provider/main.dart';
import '../api/utils/utils.dart';
import '../common/constants/constants.dart';

class AndroidApp extends StatefulWidget {
  // This widget is the root of android platform application.
  @override
  _AndroidAppState createState() => _AndroidAppState();
}

class _AndroidAppState extends State<AndroidApp> {
  Map _user;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });

    AuthUtil().getUser().then((res) {
      if (res != null) {
        setState(() {
          _user = jsonDecode(res);
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _user = null;
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(_user);
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade800,
      ),
      home: _user == null ? SignInScreen() : HomeScreen(user: {'name': 'Test'}),
      routes: {
        // Home screen
        HomeScreen.routeName: (_) => HomeScreen(),
        // Signin screen
        SignInScreen.routeName: (_) => SignInScreen(),
        // Signup screen
        SignUpScreen.routeName: (_) => SignUpScreen(),
        // About screen
        AboutScreen.routeName: (_) =>  AboutScreen(),
        // Contact screen
        ContactScreen.routeName: (_) => ContactScreen(),
        // Provider screen
        AndroidProviderScreen.routeName: (_) => AndroidProviderScreen(),
      },
    );
  }
}
