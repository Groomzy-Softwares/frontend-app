import 'package:flutter/material.dart';

import './book.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

class BookScreen extends StatelessWidget {
  static final String routeName = '/${BOOK_TITLE.toLowerCase()}';

  const BookScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AndroidAppBar(title: BOOK_TITLE,),
      drawer: AndroidDrawer(),
      body: SafeArea(
        child: AndroidCenterHorizontalVertical(screenContent: Book(),),
      ),
    );
  }
}
