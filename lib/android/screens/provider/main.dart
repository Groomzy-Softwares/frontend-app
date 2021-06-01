import 'package:flutter/material.dart';

import './provider.dart';
import '../../app_bar/app_bar.dart';
import '../../widgets/center_horizontal/center_horizontal.dart';
import '../../../common/constants/constants.dart';

class AndroidProviderScreen extends StatefulWidget {
  static final String routeName = '/${PROVIDER_TITLE.toLowerCase()}';

  const AndroidProviderScreen({Key key}) : super(key: key);

  @override
  _AndroidProviderScreenState createState() => _AndroidProviderScreenState();
}

class _AndroidProviderScreenState extends State<AndroidProviderScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(
        title: PROVIDER_TITLE,
      ),
      // drawer: AndroidDrawer(),
      body: SafeArea(
        child: CenterHorizontal(
          screenContent: AndroidProvider(selectedIndex: _selectedIndex,),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_outlined),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.preview_outlined),
            label: 'Reviews',
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
