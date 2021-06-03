import 'package:flutter/material.dart';

import './service.dart';
import '../../../widgets/filters/filters.dart';
import '../../../widgets/search/search.dart';
import '../../../widgets/sort/sort.dart';
import '../../../widgets/horizontal_scroll/staffers.dart';

class AndroidServices extends StatelessWidget {
  const AndroidServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AndroidService(),
          Divider(),
          AndroidService(),
          Divider(),
          AndroidService(),
          Divider(),
          AndroidService(),
          Divider(),
          AndroidService(),
        ],
      ),
    );
  }
}
