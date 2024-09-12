import 'dart:convert';

import 'package:flutter/material.dart';

import './screens/explorer/main.dart';
import './screens/signin/main.dart';
import './screens/signup/main.dart';
import './screens/about/main.dart';
import './screens/contacts/main.dart';
import './screens/provider_trading/main.dart';
import './screens/book/main.dart';
import './screens/checkout/main.dart';
import './screens/provider/main.dart';
import './screens/client/main.dart';

import './utils/utils.dart';

import '../common/constants/constants.dart';

import '../api/utils/utils.dart';

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

    APIUtils().getUser().then((res) {
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
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: Utils().homeScreen(_user != null ? _user['role'] : ''),
      routes: {
        // Explorer screen
        ExploreScreen.routeName: (_) => ExploreScreen(),
        // Signin screen
        SignInScreen.routeName: (_) => SignInScreen(),
        // Signup screen
        SignUpScreen.routeName: (_) => SignUpScreen(),
        // About screen
        AboutScreen.routeName: (_) =>  AboutScreen(),
        // Contact screen
        ContactScreen.routeName: (_) => ContactScreen(),
        // ProviderTrading screen
        ProviderTradingScreen.routeName: (_) => ProviderTradingScreen(),
        // Book screen
        BookScreen.routeName: (_) => BookScreen(),
        // Checkout screen
        CheckoutScreen.routeName: (_) => CheckoutScreen(),
        // Provider screen
        ProviderScreen.routeName: (_) => ProviderScreen(),
        // Client screen
        ClientScreen.routeName: (_) => ClientScreen(),
      },
    );
  }
}
