import 'package:flutter/material.dart';

class BookingOperationalDays extends StatelessWidget {
  final List dayTimes;

  const BookingOperationalDays({this.dayTimes, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150.0,
          child: Text(
            'NB! Operating days are:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...dayTimes
                  .map(
                    (dayTime) => Text(
                  dayTime['day']['day'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  .toList()
            ],
          ),
        )
      ],
    );
  }
}
