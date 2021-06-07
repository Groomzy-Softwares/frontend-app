import 'dart:convert';

import 'package:flutter/material.dart';

import './home.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

import '../../../api/utils/utils.dart';


class HomeScreen extends StatefulWidget {
  static final String routeName = '/${HOME_TITLE.toLowerCase()}';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AndroidAppBar(
        title: HOME_TITLE,
      ),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontalVertical(
          showSearch: _user['role'] == 'Client',
          screenContent: Home(user: _user),
        ),
      ),
    );
  }
}
