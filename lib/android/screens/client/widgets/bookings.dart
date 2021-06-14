import 'package:flutter/material.dart';

import 'booking.dart';

class Bookings extends StatelessWidget {
  const Bookings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[1, 2, 3, 4, 5, 7, 8, 9, 10]
            .map((booking) => Column(
                  children: [
                    Booking(),
                    Divider(),
                  ],
                ))
            .toList(),
      ],
    );
  }
}
