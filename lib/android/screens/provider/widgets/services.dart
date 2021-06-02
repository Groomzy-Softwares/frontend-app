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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AndroidSearch(),
                AndroidFilters(),
                Text(
                  '|',
                  style: TextStyle(fontSize: 30.0),
                ),
                AndroidSort(),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Staffers',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Staffers(),
              ],
            ),
          ),
          Divider(),
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
