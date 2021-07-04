import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './provider_trading.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/center_horizontal/center_horizontal.dart';
import '../../../common/constants/constants.dart';

class ProviderTradingScreen extends HookWidget {
  static final String routeName = '/${PROVIDER_TRADING_TITLE.toLowerCase()}';

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);

    void _onItemTapped(int index) {
      _selectedIndex.value = index;
    }

    final Map arguments = ModalRoute.of(context).settings.arguments;
    int providerId = arguments['providerId'];
    int minimumDuration = arguments['minimumDuration'];
    Map address = arguments['address'];
    List services = arguments['services'] ?? [];
    List staffs = arguments['staffs'] ?? [];
    List dayTimes = arguments['dayTimes'] ?? [];
    List ratings = arguments['ratings'] ?? [];

    return Scaffold(
      appBar: AndroidAppBar(
        title: PROVIDER_TRADING_TITLE,
      ),
      // drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontal(
          screenContent: ProviderTrading(
            selectedIndex: _selectedIndex.value,
            providerId: providerId,
            services: services,
            staffs: staffs,
            dayTimes: dayTimes,
            minimumDuration: minimumDuration,
            ratings: ratings,
              address: address,
          ),
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
        currentIndex: _selectedIndex.value,
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
