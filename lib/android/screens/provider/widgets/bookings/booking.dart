import 'package:flutter/material.dart';
import 'package:groomzy/android/widgets/button/button.dart';

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
    Widget tableHeader(String header) {
      return TableCell(
        child: Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      );
    }

    Widget tableCell(String value) {
      return TableCell(
        child: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Container(
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: Column(
          children: [
            Divider(height: 0,),
            Container(
              margin: EdgeInsets.only(
                left: 10.0,
                top: 10.0,
              ),
              child: Table(
                children: [
                  TableRow(children: [
                    tableHeader('Title'),
                    tableHeader('Date time'),
                    tableHeader('InHouse'),
                    tableHeader('Client'),
                  ]),
                  TableRow(children: [
                    Divider(),
                    Divider(),
                    Divider(),
                    Divider(),
                  ]),
                  TableRow(children: [
                    tableCell(service['title']),
                    tableCell('$bookingDate $bookingTime hrz'),
                    tableCell(inHouse ? 'Yes' : 'No'),
                    tableCell(bookedBy),
                  ]),
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
                    height: 35,
                    width: 90,
                    child: AndroidButton(
                      label: 'View',
                      icon: Icons.remove_red_eye_outlined,
                      fontSize: 16,
                      iconSize: 18,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 90,
                    child: AndroidButton(
                      label: 'Done',
                      icon: Icons.done_outline,
                      backgroundColor: Colors.green,
                      fontSize: 16,
                      iconSize: 18,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 90,
                    child: AndroidButton(
                      label: 'Cancel',
                      icon: Icons.delete_forever_outlined,
                      backgroundColor: Colors.redAccent,
                      fontSize: 16,
                      iconSize: 18,
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
