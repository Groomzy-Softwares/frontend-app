import 'package:flutter/material.dart';

import '../../widgets/horizontal_scroll/category_labels.dart';
import '../../widgets/search/search.dart';
import '../../widgets/filters/filters.dart';
import '../../widgets/summary_service_provider/summary_service_provider.dart';
import '../../widgets/sort/sort.dart';

class Home extends StatelessWidget {
  final Map user;

  const Home({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AndroidSearch(),
                AndroidFilters(),
                Text('|', style: TextStyle(fontSize: 30.0)),
                AndroidSort(),
              ],
            ),
          ),
          Divider(),
          CategoryLabels(),
          Divider(),
          AndroidService(),
          AndroidService(),
          AndroidService(),
        ],
      ),
    );
  }
}
