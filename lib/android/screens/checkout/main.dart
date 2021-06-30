import 'package:flutter/material.dart';

import './checkout.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/center_horizontal_vertical/center_horizontal_vertical.dart';
import '../../../common/constants/constants.dart';

class CheckoutScreen extends StatelessWidget {
  static final String routeName = '/${CHECKOUT_TITLE.toLowerCase()}';

  const CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final String name = arguments['name'];
    final String category = arguments['category'];
    final String description = arguments['description'];
    final double price = arguments['price'];
    final int bookingId = arguments['bookingId'];
    final Function bookingStatusMutation = arguments['bookingStatusMutation'];

    return Checkout(
      category: category,
      bookingId: bookingId,
      bookingStatusMutation: bookingStatusMutation,
      description: description,
      name: name,
      price: price,
    );
  }
}
