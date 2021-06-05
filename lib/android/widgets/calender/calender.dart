import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AndroidCalendar extends StatelessWidget {
  final DateTime dateNow;
  final CalendarFormat calendarFormat;
  final DateTime selectedDay;
  final Function onDaySelected;
  final Function onFormatChanged;

  const AndroidCalendar({
    this.dateNow,
    this.calendarFormat,
    this.selectedDay,
    this.onDaySelected,
    this.onFormatChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: dateNow,
      lastDay: dateNow.add(Duration(days: 10 * 365)),
      focusedDay: dateNow,
      rowHeight: 40.0,
      calendarFormat: calendarFormat,
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChanged,
      calendarStyle: CalendarStyle(
        // Use `CalendarStyle` to customize the UI
        isTodayHighlighted: true,
        selectedTextStyle: TextStyle(
          backgroundColor: Theme.of(context).primaryColor,
          color: Colors.white,
        ),
      ),
    );
  }
}
