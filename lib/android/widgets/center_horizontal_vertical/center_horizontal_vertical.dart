import 'package:flutter/material.dart';
import 'package:groomzy/android/widgets/filters/filters.dart';
import 'package:groomzy/android/widgets/search/search.dart';

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
                  padding: EdgeInsets.only(bottom: 20.0),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AndroidSearch(),
                      AndroidFilters(),
                    ],
                  ),
                ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: screenContent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
