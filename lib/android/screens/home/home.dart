import 'package:flutter/material.dart';

import '../../widgets/horizontal_scroll/category_labels.dart';
import '../../widgets/summary_service_provider/summary_service_provider.dart';

class Home extends StatelessWidget {
  final Map user;

  const Home({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AndroidCategoryLabels(),
          Divider(),
          AndroidService(),
          AndroidService(),
          AndroidService(),
        ],
      ),
    );
  }
}
