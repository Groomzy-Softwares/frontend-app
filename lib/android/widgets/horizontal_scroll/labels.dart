import 'package:flutter/material.dart';

import '../../../common/constants/constants.dart';

class AndroidLabels extends StatelessWidget {
  final List categories;

  const AndroidLabels({this.categories, Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: categories != null && categories.length > 0 ? categories
            .map(
              (category) => Container(
                child: Card(
                  color: Colors.white70,
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3,),
                    child: Text(
                      category,
                    ),
                  ),
                ),
              ),
            )
            .toList() : [Text('No categories.')].toList(),
      ),
    );
  }
}
