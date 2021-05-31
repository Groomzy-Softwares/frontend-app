import 'package:flutter/material.dart';

import '../../../common/constants/constants.dart';

class Labels extends StatelessWidget {
  const Labels({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const categories = [
      {'category': BARBER},
      {'category': HAIRDRESSER},
      {'category': MAKEUP_ARTIST},
      {'category': SPA},
      {'category': NAIL_TECHNICIAN},
    ];
    return Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: categories
            .map(
              (category) => Container(
                child: Card(
                  color: Colors.white70,
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3,),
                    child: Text(
                      category['category'],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
