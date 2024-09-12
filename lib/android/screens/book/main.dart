import 'package:flutter/material.dart';

import './book.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/center_horizontal/center_horizontal.dart';
import '../../../common/constants/constants.dart';

class BookScreen extends StatelessWidget {
  static final String routeName = '/${BOOK_TITLE.toLowerCase()}';

  const BookScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AndroidAppBar(
        title: BOOK_TITLE,
      ),
      body: SafeArea(
        child: AndroidCenterHorizontal(
          screenContent: Book(
            providerId: arguments['providerId'],
            price: arguments['price'],
            description: arguments['description'],
            name: arguments['name'],
            serviceId: arguments['serviceId'],
            staffs: arguments['staffs'] ?? [],
            dayTimes: arguments['dayTimes'] ?? [],
            minimumDuration: arguments['minimumDuration'],
            duration: arguments['duration'],
            bookings: arguments['bookings'],
          ),
        ),
      ),
    );
  }
}
