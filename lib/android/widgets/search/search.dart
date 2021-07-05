import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import '../text_field/text_field.dart';

import '../../../common/utils/utils.dart';

class AndroidSearch extends StatelessWidget {
  final ValueNotifier<String> search;

  const AndroidSearch({this.search, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: AndroidTextField(
        value: search.value,
        label: 'Search',
        suffixIcon: Icons.search_outlined,
        borderRadius: 50,
        onInputChange: (String input) {
          EasyDebounce.debounce(
            'search-deBouncer', // <-- An ID for this particular deBouncer
            Duration(seconds: 3), // <-- The debounce duration
            () {
              CommonUtils().setExplorerSearch(input);
              search.value = input;
            }, // <-- The target method
          );
        },
      ),
    );
  }
}
