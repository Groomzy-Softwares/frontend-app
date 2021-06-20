import 'package:flutter/material.dart';

import '../filters/filters.dart';
import '../search/search.dart';

class AndroidCenterHorizontalVerticalExpanded extends StatelessWidget {
  final Widget screenContent;
  final bool showSearch;

  AndroidCenterHorizontalVerticalExpanded({
    @required this.screenContent,
    this.showSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showSearch)
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 20.0),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AndroidSearch(),
                AndroidFilters(),
              ],
            ),
          ),
        Expanded(child: screenContent),
      ],
    );
  }
}
