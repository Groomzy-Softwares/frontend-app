import 'package:flutter/material.dart';

import '../category/category.dart';
import '../../../common/constants/constants.dart';

class CategoryLabels extends StatelessWidget {
  const CategoryLabels({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const categories = [
      {'imageAssetPath': BARBER_IMAGE, 'category': BARBER},
      {'imageAssetPath': HAIRDRESSER_IMAGE, 'category': HAIRDRESSER},
      {'imageAssetPath': MAKEUP_ARTIST_IMAGE, 'category': MAKEUP_ARTIST},
      {'imageAssetPath': SPA_IMAGE, 'category': SPA},
      {'imageAssetPath': NAIL_TECHNICIAN_IMAGE, 'category': NAIL_TECHNICIAN},
    ];
    return Container(
      height: 160,
      margin: EdgeInsets.only(top: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: categories
            .map(
              (category) => Category(
                imageAssetPath: category['imageAssetPath'],
                category: category['category'],
              ),
            )
            .toList(),
      ),
    );
  }
}
