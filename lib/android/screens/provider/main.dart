import 'dart:convert';

import 'package:flutter/material.dart';

import './provider.dart';
import '../explorer/main.dart';
import '../../widgets/alert_dialog/alert_dialog.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

import '../../../api/utils/utils.dart';

class ProviderScreen extends StatefulWidget {
  static final String routeName = '/${PROVIDER_TITLE.toLowerCase()}';

  const ProviderScreen({Key key}) : super(key: key);

  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  int _selectedIndex = 0;
  Map _user;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return AndroidLoading();
    } else if(_user == null) {
      return AndroidAlertDialog(
        title: 'Info',
        message: Text('It appears you are no longer signed in, please sign in.'),
        navigateTo: ExploreScreen.routeName,
        replacePreviousNavigation: true,
      );
    } else {
      return Scaffold(
        appBar: AndroidAppBar(
          title: PROVIDER_TITLE,
        ),
        drawer: AndroidDrawer(),
        body: SafeArea(
          child: AndroidCenterHorizontalVertical(
            screenContent: Provider(selectedIndex: _selectedIndex,),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.business_center_outlined),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_outlined),
              label: 'Time',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedIconTheme: IconThemeData(size: 30.0),
          selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
          selectedFontSize: 18,
          unselectedItemColor: Colors.black26,
          onTap: _onItemTapped,
        ),
      );
    }
  }
}
