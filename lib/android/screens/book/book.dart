import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import './widgets/booking_times.dart';
import '../checkout/main.dart';
import '../../widgets/calender/calender.dart';
import '../../widgets/checkbox/checkbox.dart';
import '../../widgets/heading/heading.dart';
import '../../widgets/text_field/text_field.dart';
import '../../widgets/horizontal_scroll/staffers.dart';

class Book extends HookWidget {
  final String name;
  final String category;
  final String description;
  final double price;
  final int serviceId;

  Book({
    this.category,
    this.description,
    this.name,
    this.price,
    this.serviceId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarFormat = useState(CalendarFormat.twoWeeks);
    final _dateNow = useState<DateTime>(DateTime.now());
    final _selectedDay = useState<DateTime>(null);
    final _selectedTime = useState<String>(null);
    final _selectedStaffer = useState<String>(null);
    final _serviceCallAddress = useState<String>(null);
    final _inHouse = useState<bool>(false);

    return Container(
      margin: EdgeInsets.all(10.0,),
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
            dateNow: _dateNow.value,
            calendarFormat: _calendarFormat.value,
            selectedDay: _selectedDay.value,
            onDaySelected: (selectedDay, focusedDa) {
              _selectedDay.value = selectedDay;
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                _calendarFormat.value = format;
              }
            },
          ),
          if (_selectedDay.value != null) Divider(),
          if (_selectedDay.value != null) AndroidHeading(title: 'Select time'),
          if (_selectedDay.value != null)
            BookingTimes(
              selectTime: (time) {
                _selectedTime.value = time;
              },
              times: [
                '09:00',
                '09:30',
                '10:00',
                '10:30',
                '11:00',
                '11:30',
                '12:00',
                '12:30'
              ],
            ),
          if (_selectedTime.value != null) Divider(),
          if (_selectedTime.value != null)
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
          if (_selectedTime.value != null)
            AndroidCheckBox(
              label: 'Is this an in house service call?',
              checked: _inHouse.value,
              onChecked: (check) {
                _inHouse.value = check;
                _serviceCallAddress.value = null;
                _selectedStaffer.value = null;
              },
            ),
          if (_inHouse.value) Divider(),
          if (_inHouse.value)
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
          if (_inHouse.value)
            AndroidTextField(
              prefixIcon: Icons.location_on_outlined,
              label: 'Address',
              onInputChange: (input) {
                _serviceCallAddress.value = input;
              },
            ),
          if ((_inHouse.value &&
                  _serviceCallAddress.value != null &&
                  _selectedTime.value != null) ||
              (!_inHouse.value &&
                  _serviceCallAddress.value == null &&
                  _selectedTime.value != null))
            Divider(),
          if ((_inHouse.value &&
                  _serviceCallAddress.value != null &&
                  _selectedTime.value != null) ||
              (!_inHouse.value &&
                  _serviceCallAddress.value == null &&
                  _selectedTime.value != null))
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
          if ((_inHouse.value &&
                  _serviceCallAddress.value != null &&
                  _selectedTime.value != null) ||
              (!_inHouse.value &&
                  _serviceCallAddress.value == null &&
                  _selectedTime.value != null))
            AndroidStaffers(
              onSelectStaffer: (selectedStaffer) {
                _selectedStaffer.value = selectedStaffer;
              },
              selectedStaffer: _selectedStaffer.value,
            ),
          if ((_inHouse.value &&
                  _serviceCallAddress.value != null &&
                  _selectedDay.value != null &&
                  _selectedTime.value != null &&
                  _selectedStaffer.value != null) ||
              (!_inHouse.value &&
                  _serviceCallAddress.value == null &&
                  _selectedDay.value != null &&
                  _selectedTime.value != null &&
                  _selectedStaffer.value != null))
            Container(
              width: double.infinity,
              height: 50.0,
              color: Theme.of(context).primaryColor,
              child: TextButton(
                onPressed: () {
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.moneyBill,
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
