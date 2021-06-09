import 'package:flutter/material.dart';

import './client.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../../common/constants/constants.dart';

class ClientScreen extends StatefulWidget {
  static final String routeName = '/${CLIENT_TITLE.toLowerCase()}';

  const ClientScreen({Key key}) : super(key: key);

  @override
  _ProviderTradingScreenState createState() => _ProviderTradingScreenState();
}

class _ProviderTradingScreenState extends State<ClientScreen> {
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
        title: EXPLORER_TITLE,
      ),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: Client(selectedIndex: _selectedIndex,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_outlined),
            label: 'Providers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Bookings',
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
