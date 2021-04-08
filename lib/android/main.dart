import 'dart:convert';

import 'package:flutter/material.dart';

import './screens/home/home.dart';
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
        primarySwatch: Colors.blueGrey,
      ),
      home: Home(user: {'name': 'Sifiso'},),
    );
  }
}