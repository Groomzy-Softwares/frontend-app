import 'package:flutter/material.dart';

import '../../widgets/filters/filters.dart';
import '../../widgets/search/search.dart';

class AndroidCenterHorizontalVertical extends StatelessWidget {
  final Widget screenContent;
  final bool showSearch;

  AndroidCenterHorizontalVertical({
    @required this.screenContent,
    this.showSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showSearch)
                Container(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AndroidSearch(),
                      AndroidFilters(),
                    ],
                  ),
                ),
              Container(
                // padding: EdgeInsets.all(10.0),
                child: screenContent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
