import 'package:flutter/material.dart';

import '../../widgets/horizontal_scroll/category_labels.dart';
import '../../widgets/summary_service_provider/summary_service_provider.dart';

class ClientHome extends StatelessWidget {
  final Map user;

  const ClientHome({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user);
    return Container(
      child: Column(
        children: [
          AndroidCategoryLabels(),
          Divider(),
          AndroidSummaryService(),
          AndroidSummaryService(),
          AndroidSummaryService(),
        ],
      ),
    );
  }
}
