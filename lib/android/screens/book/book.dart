import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Book extends StatefulWidget {
  const Book({Key key}) : super(key: key);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _dateNow = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar(
            firstDay: _dateNow,
            lastDay: _dateNow.add(Duration(days: 10 * 365)),
            focusedDay: _dateNow,
            rowHeight: 35.0,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  // _dateNow = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            // onPageChanged: (focusedDay) {
            //   // No need to call `setState()` here
            //   _dateNow = focusedDay;
            // },
            calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                isTodayHighlighted: true,
                selectedTextStyle: TextStyle(
                  backgroundColor: Theme.of(context).primaryColor,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
