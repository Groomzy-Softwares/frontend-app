import 'package:flutter/material.dart';
import 'package:groomzy/api/utils/utils.dart';
import '../../../../common/types/types.dart';

class AndroidDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String navigateTo;
  final NavigatorNamedType navigateType;

  const AndroidDrawerItem({
    this.icon,
    this.title,
    this.navigateTo,
    this.navigateType,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
      ),
      onTap: () async {
        if (navigateTo != null) {
          if (title == 'Sign out') {
            await AuthUtil().setToken(null);
            await AuthUtil().setUser(null);

            Navigator.of(context).pushReplacementNamed(navigateTo);
          } else {
            switch (navigateType) {
              case NavigatorNamedType.POP_AND_PUSH:
                Navigator.of(context).popAndPushNamed(navigateTo);
                break;
              case NavigatorNamedType.PUSH_REPLACE:
                Navigator.of(context).pushReplacementNamed(navigateTo);
                break;
              default:
                Navigator.of(context).pushNamed(navigateTo);
            }
          }
        }
      },
    );
  }
}
