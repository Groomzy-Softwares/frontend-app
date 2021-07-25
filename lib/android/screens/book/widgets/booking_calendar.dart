import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:groomzy/android/widgets/calender/calender.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends HookWidget {
  final ValueNotifier<DateTime> dateNow;
  final ValueNotifier<CalendarFormat> calendarFormat;
  final ValueNotifier<DateTime> selectedDay;
  final ValueNotifier<String> selectedTime;
  final List dayTimes;

  const BookingCalendar({
    this.dateNow,
    this.calendarFormat,
    this.selectedTime,
    this.selectedDay,
    this.dayTimes,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndroidCalendar(
      dateNow: dateNow.value,
      calendarFormat: calendarFormat.value,
      selectedDay: selectedDay.value,
      onDaySelected: (_selectedDay, focusedDa) {
        String day =
            DateFormat.yMEd().add_jms().format(_selectedDay).split(',')[0];
        List activeDays =
            dayTimes.where((dayTime) => dayTime['day']['day'] == day).toList();

        if (activeDays.length < 1) {
          selectedTime.value = null;
        }
        selectedDay.value = _selectedDay;
      },
      onFormatChanged: (format) {
        if (calendarFormat != format) {
          // Call `setState()` when updating calendar format
          calendarFormat.value = format;
        }
      },
    );
  }
}
