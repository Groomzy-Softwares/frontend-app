import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import './widgets/booking_times.dart';
import '../checkout/main.dart';
import '../../widgets/calender/calender.dart';
import '../../widgets/button/button.dart';
import '../../widgets/checkbox/checkbox.dart';
import '../../widgets/heading/heading.dart';
import '../../widgets/text_field/text_field.dart';

class Book extends HookWidget {
  final String name;
  final String category;
  final String description;
  final double price;
  final int serviceId;
  final int minimumDuration;
  final int duration;
  final List staffs;
  final List dayTimes;

  Book({
    this.category,
    this.description,
    this.name,
    this.price,
    this.serviceId,
    this.staffs,
    this.dayTimes,
    this.minimumDuration,
    this.duration,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarFormat = useState(CalendarFormat.twoWeeks);
    final _dateNow = useState<DateTime>(DateTime.now());
    final _selectedDay = useState<DateTime>(null);
    final _selectedTime = useState<String>(null);
    final _selectedStaffer = useState<String>(null);
    final _selectedStafferId = useState<int>(null);
    final _serviceCallAddress = useState<String>(null);
    final _inHouse = useState<bool>(false);

    bool canSelectTime() {
      String day =
          DateFormat.yMEd().add_jms().format(_selectedDay.value).split(',')[0];
      List activeDays =
          dayTimes.where((dayTime) => dayTime['day']['day'] == day).toList();
      return activeDays.length > 0;
    }

    bool canBook() {
      return (_inHouse.value &&
              _serviceCallAddress.value != null &&
              _selectedDay.value != null &&
              _selectedTime.value != null &&
              _selectedStaffer.value != null) ||
          (!_inHouse.value &&
              _serviceCallAddress.value == null &&
              _selectedDay.value != null &&
              _selectedTime.value != null &&
              _selectedStaffer.value != null);
    }

    bool canSelectStaff() {
      return (_inHouse.value &&
              _serviceCallAddress.value != null &&
              _selectedTime.value != null) ||
          (!_inHouse.value &&
              _serviceCallAddress.value == null &&
              _selectedTime.value != null);
    }

    return Container(
      margin: EdgeInsets.all(
        10.0,
      ),
      child: Column(
        children: [
          Divider(),
          Row(
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
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                        .toList()
                  ],
                ),
              )
            ],
          ),
          Divider(),
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
            dateNow: _dateNow.value,
            calendarFormat: _calendarFormat.value,
            selectedDay: _selectedDay.value,
            onDaySelected: (selectedDay, focusedDa) {
              String day =
                  DateFormat.yMEd().add_jms().format(selectedDay).split(',')[0];
              List activeDays = dayTimes
                  .where((dayTime) => dayTime['day']['day'] == day)
                  .toList();

              if (activeDays.length < 1) {
                _selectedTime.value = null;
              }
              _selectedDay.value = selectedDay;
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                _calendarFormat.value = format;
              }
            },
          ),
          if (_selectedDay.value != null)
            Column(
              children: [
                Divider(),
                AndroidHeading(title: 'Select time'),
                BookingTimes(
                  selectTime: (time) {
                    _selectedTime.value = time;
                    _selectedStaffer.value = null;
                  },
                  dayTimes: dayTimes,
                  selectedDay: _selectedDay.value,
                  selectedTime: _selectedTime.value,
                  minimumDuration: minimumDuration,
                ),
              ],
            ),
          if (_selectedTime.value != null && canSelectTime())
            Column(
              children: [
                Divider(),
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
                AndroidCheckBox(
                  label: 'Is this an in house service call?',
                  checked: _inHouse.value,
                  onChecked: (check) {
                    _inHouse.value = check;
                    _serviceCallAddress.value = null;
                    _selectedStaffer.value = null;
                  },
                ),
              ],
            ),
          if (_inHouse.value && canSelectTime())
            Column(
              children: [
                Divider(),
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
                AndroidTextField(
                  prefixIcon: Icons.location_on_outlined,
                  label: 'Address',
                  onInputChange: (input) {
                    _serviceCallAddress.value = input;
                  },
                ),
              ],
            ),
          if (canSelectStaff() && canSelectTime())
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
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
                SizedBox(
                  height: 10.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...staffs
                          .map(
                            (staff) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectedStaffer.value = staff['fullName'];
                                    _selectedStafferId.value = staff['id'];
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor:
                                          _selectedStaffer.value != null
                                              ? Colors.green
                                              : Colors.black12,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          staff['fullName']
                                              .toString()
                                              .split(' ')[0][0]
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  staff['fullName'].toString().split(' ')[0],
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          if (canBook() && canSelectTime())
            AndroidButton(
              label: 'Checkout',
              backgroundColor: Colors.green,
              pressed: () {
                Navigator.of(context).pushNamed(
                  CheckoutScreen.routeName,
                  arguments: {
                    'serviceId': serviceId,
                    'name': name,
                    'description': description,
                    'price': price,
                    'category': category,
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
