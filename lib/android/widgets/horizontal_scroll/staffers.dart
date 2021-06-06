import 'package:flutter/material.dart';

import '../staffer/staffer.dart';
import '../../../common/constants/constants.dart';

class AndroidStaffers extends StatelessWidget {
  final String selectedStaffer;
  final Function onSelectStaffer;

  const AndroidStaffers({this.selectedStaffer, this.onSelectStaffer, Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const staffers = [
      {'imageAssetPath': BARBER_IMAGE, 'name': BARBER},
      {'imageAssetPath': HAIRDRESSER_IMAGE, 'name': HAIRDRESSER},
      {'imageAssetPath': MAKEUP_ARTIST_IMAGE, 'name': MAKEUP_ARTIST},
      {'imageAssetPath': SPA_IMAGE, 'name': SPA},
      {'imageAssetPath': NAIL_TECHNICIAN_IMAGE, 'name': NAIL_TECHNICIAN},
    ];
    return Container(
      height: 130,
      margin: EdgeInsets.only(top: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: staffers
            .map(
              (category) => AndroidStaffer(
                selectedStaffer: selectedStaffer,
                onSelectStaffer: onSelectStaffer,
                imageAssetPath: category['imageAssetPath'],
                name: category['name'],
              ),
            )
            .toList(),
      ),
    );
  }
}
