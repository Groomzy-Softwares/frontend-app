import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:groomzy/android/screens/explorer/main.dart';
import 'package:groomzy/android/widgets/alert_dialog/alert_dialog.dart';
import 'package:groomzy/android/widgets/loading/loading.dart';

import './client.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../../common/constants/constants.dart';

import '../../../api/utils/utils.dart';

class ClientScreen extends HookWidget {
  static final String routeName = '/${CLIENT_TITLE.toLowerCase()}';

  const ClientScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);
    final _user = useState({});
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
          title: EXPLORER_TITLE,
        ),
        drawer: AndroidDrawer(),
        body: SafeArea(
          child: Client(selectedIndex: _selectedIndex.value,),
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
