import 'package:flutter/material.dart';

import '../../widgets/horizontal_scroll/horizontal_scroll.dart';
import '../../widgets/search/search.dart';
import '../../widgets/filters/filters.dart';
import '../../widgets/service/service.dart';

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
              ],
            ),
          ),
          HorizontalScroll(),
          AndroidService(),
          AndroidService(),
          AndroidService(),
        ],
      ),
    );
  }
}
