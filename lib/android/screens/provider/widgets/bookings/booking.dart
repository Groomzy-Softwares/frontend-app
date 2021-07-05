import 'package:flutter/material.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/table/table_cell.dart';
import '../../../../widgets/table/table_header.dart';

class Booking extends StatelessWidget {
  final int bookingId;
  final String bookedBy;
  final String bookingDate;
  final String bookingTime;
  final bool inHouse;
  final Map service;

  const Booking({
    this.bookingId,
    this.bookedBy,
    this.bookingDate,
    this.bookingTime,
    this.inHouse,
    this.service,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: Column(
          children: [
            Divider(
              height: 0,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10.0,
                top: 10.0,
              ),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      TableHeader(header: 'Title'),
                      TableHeader(header: 'Date time'),
                      TableHeader(header: 'InHouse'),
                      TableHeader(header: 'Client'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Divider(),
                      Divider(),
                      Divider(),
                      Divider(),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableValue(value: service['title']),
                      TableValue(value: '$bookingDate $bookingTime hrz'),
                      TableValue(value: inHouse ? 'Yes' : 'No'),
                      TableValue(value: bookedBy),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 35.0,
                    width: 100.0,
                    child: AndroidButton(
                      label: 'View',
                      icon: Icons.remove_red_eye_outlined,
                      fontSize: 16.0,
                      iconSize: 18.0,
                    ),
                  ),
                  Container(
                    height: 35.0,
                    width: 100.0,
                    child: AndroidButton(
                      label: 'Done',
                      icon: Icons.done_outline,
                      backgroundColor: Colors.green,
                      fontSize: 16.0,
                      iconSize: 18.0,
                    ),
                  ),
                  Container(
                    height: 35.0,
                    width: 100.0,
                    child: AndroidButton(
                      label: 'Cancel',
                      icon: Icons.delete_forever_outlined,
                      backgroundColor: Colors.redAccent,
                      fontSize: 16.0,
                      iconSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
