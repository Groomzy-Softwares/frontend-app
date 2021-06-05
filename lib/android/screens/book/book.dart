import 'package:flutter/material.dart';
import 'package:groomzy/android/screens/book/widgets/booking_times.dart';
import 'package:groomzy/android/screens/home/main.dart';
import 'package:groomzy/android/widgets/calender/calender.dart';
import 'package:groomzy/android/widgets/checkbox/checkbox.dart';
import 'package:groomzy/android/widgets/heading/heading.dart';
import 'package:groomzy/android/widgets/text_field/text_field.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/horizontal_scroll/staffers.dart';

class Book extends StatefulWidget {
  const Book({Key key}) : super(key: key);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _dateNow = DateTime.now();
  DateTime _selectedDay;
  String _selectedTime;
  String _selectedStaffer;
  String _serviceCallAddress;
  bool _inHouse = false;

  @override
  Widget build(BuildContext context) {
    print(_selectedDay);
    print(_selectedTime);
    print(_selectedStaffer);
    print(_inHouse);
    print(_serviceCallAddress);
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select date',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
          AndroidCalendar(
            dateNow: _dateNow,
            calendarFormat: _calendarFormat,
            selectedDay: _selectedDay,
            onDaySelected: (selectedDay, focusedDa) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
          ),
          if (_selectedDay != null) Divider(),
          if (_selectedDay != null)
            AndroidHeading(title: 'Select time'),
          if (_selectedDay != null)
            BookingTimes(
              selectTime: (time) {
                setState(() {
                  _selectedTime = time;
                });
              },
              times: ['09:00', '09:30', '10:00', '10:30','11:00','11:30', '12:00', '12:30'],
            ),
          if (_selectedTime != null) Divider(),
          if (_selectedTime != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose service location',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          if (_selectedTime != null)
            AndroidCheckBox(
              label: 'Is this an in house service call?',
              checked: _inHouse,
              onChecked: (check) {
                setState(() {
                  _inHouse = check;
                  _serviceCallAddress = null;
                  _selectedStaffer = null;
                });
              },
            ),
          if (_inHouse) Divider(),
          if (_inHouse)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter address',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          if (_inHouse)
            AndroidTextField(
              prefixIcon: Icons.location_on_outlined,
              label: 'Address',
              onInputChange: (input) {
                setState(() {
                  _serviceCallAddress = input == '' ? null : input;
                });
              },
            ),
          if ((_inHouse &&
                  _serviceCallAddress != null &&
                  _selectedTime != null) ||
              (!_inHouse &&
                  _serviceCallAddress == null &&
                  _selectedTime != null))
            Divider(),
          if ((_inHouse &&
                  _serviceCallAddress != null &&
                  _selectedTime != null) ||
              (!_inHouse &&
                  _serviceCallAddress == null &&
                  _selectedTime != null))
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select staffer',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          if ((_inHouse &&
                  _serviceCallAddress != null &&
                  _selectedTime != null) ||
              (!_inHouse &&
                  _serviceCallAddress == null &&
                  _selectedTime != null))
            AndroidStaffers(
              selectedStaffer: (selectedStaffer){
                print(selectedStaffer);
                setState(() {
                  _selectedStaffer = selectedStaffer;
                });
              },
            ),
          if ((_inHouse &&
                  _serviceCallAddress != null &&
                  _selectedDay != null &&
                  _selectedTime != null &&
                  _selectedStaffer != null) ||
              (!_inHouse &&
                  _serviceCallAddress == null &&
                  _selectedDay != null &&
                  _selectedTime != null &&
                  _selectedStaffer != null))
            Container(
              width: double.infinity,
              height: 50.0,
              color: Theme.of(context).primaryColor,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.money_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      'Checkout',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22.0),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
