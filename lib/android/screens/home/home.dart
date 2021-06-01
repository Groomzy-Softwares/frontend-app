import 'package:flutter/material.dart';

import '../../widgets/horizontal_scroll/category_labels.dart';
import '../../widgets/search/search.dart';
import '../../widgets/filters/filters.dart';
import '../../widgets/service/service.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AndroidSearch(),
                AndroidFilters(),
                Text('|', style: TextStyle(fontSize: 30),),
                AndroidSort(),
              ],
            ),
          ),
          CategoryLabels(),
          AndroidService(),
          AndroidService(),
          AndroidService(),
        ],
      ),
    );
  }
}
