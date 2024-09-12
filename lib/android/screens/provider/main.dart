import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './provider.dart';
import '../explorer/main.dart';
import '../../widgets/alert_dialog/alert_dialog.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../../common/constants/constants.dart';

import '../../../api/utils/utils.dart';

class ProviderScreen extends HookWidget {
  static final String routeName = '/${PROVIDER_TITLE.toLowerCase()}';

  const ProviderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);
    final _user = useState<Map>(null);
    final _isLoading = useState(true);

    void _onItemTapped(int index) {
      _selectedIndex.value = index;
    }

    useEffect(() {
      APIUtils().getUser().then((res) {
        if (res != null) {
          _user.value = jsonDecode(res);
        }
      }).catchError((error) {
        _user.value = null;
      });
      _isLoading.value = false;
      return;
    }, const []);

    if (_isLoading.value) {
      return AndroidLoading();
    } else if (_user.value == null) {
      return AndroidAlertDialog(
        title: 'Info',
        message:
            Text('It appears you are no longer signed in, please sign in.'),
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
          child: Provider(
            selectedIndex: _selectedIndex.value,
            providerId: _user.value['id'],
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
              icon: Icon(Icons.group_outlined),
              label: 'Staffs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_outlined),
              label: 'Time',
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
}
