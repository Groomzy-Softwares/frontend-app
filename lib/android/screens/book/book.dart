import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:groomzy/android/screens/book/widgets/booking_calendar.dart';
import 'package:groomzy/android/screens/book/widgets/booking_operational_days.dart';
import 'package:groomzy/android/widgets/alert_dialog/alert_dialog.dart';
import 'package:groomzy/api/graphql/mutations/client/book.dart';
import 'package:groomzy/common/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import './widgets/booking_times.dart';
import '../checkout/main.dart';
import '../../widgets/button/button.dart';
import '../../widgets/checkbox/checkbox.dart';
import '../../widgets/heading/heading.dart';
import '../../widgets/text_field/text_field.dart';

class Book extends HookWidget {
  final int providerId;
  final String name;
  final String category;
  final String description;
  final double price;
  final int serviceId;
  final int minimumDuration;
  final int duration;
  final List staffs;
  final List dayTimes;
  final List bookings;

  Book({
    this.providerId,
    this.category,
    this.description,
    this.name,
    this.price,
    this.serviceId,
    this.staffs,
    this.dayTimes,
    this.minimumDuration,
    this.duration,
    this.bookings,
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

    Future<void> _submit({Function clientBook}) async {
      var x = DateFormat('yyyy-MM-dd').format(_selectedDay.value);
      print(x);
      await clientBook({
        'providerId': providerId,
        'serviceId': serviceId,
        'staffId': _selectedStafferId.value,
        'bookingDate': DateFormat('yyyy-MM-dd').format(_selectedDay.value),
        'bookingTime': _selectedTime.value,
        'inHouse': _inHouse.value,
        'address': _serviceCallAddress.value,
      });
    }

    return Mutation(
      options: MutationOptions(
        document: gql(ClientBookMutation().clientBook),
        update: (
          GraphQLDataProxy cache,
          QueryResult result,
        ) {
          if (result.hasException) {
            String errMessage = result.exception.graphqlErrors[0].message;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AndroidAlertDialog(
                  title: 'Error',
                  message: Text(
                    errMessage,
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                );
              },
            );
          }
          return cache;
        },
        onCompleted: (dynamic clientBookResult) async {
          print(clientBookResult);
          if (clientBookResult != null) {
            print(clientBookResult);
            Map booking = clientBookResult['clientBook'];
            if (booking.isNotEmpty && booking['id'] != null) {
              // Go to the checkout screen
              Navigator.of(context).pushNamed(
                CheckoutScreen.routeName,
                arguments: {
                  'bookingId': booking['id'],
                  'serviceId': serviceId,
                  'name': name,
                  'description': description,
                  'price': price,
                  'category': category,
                },
              );
            }
          }
        },
      ),
      builder: (
        RunMutation runBookMutation,
        QueryResult bookResult,
      ) {
        return Container(
          margin: EdgeInsets.all(
            10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingOperationalDays(dayTimes: dayTimes),
              Divider(
                height: 20.0,
              ),
              AndroidHeading(title: 'Select date'),
              Divider(),
              if (_selectedDay.value != null)
                Text(
                  'Selected date: ${DateFormat.yMEd().format(_selectedDay.value)}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              BookingCalendar(
                dateNow: _dateNow,
                calendarFormat: _calendarFormat,
                selectedDay: _selectedDay,
                selectedTime: _selectedTime,
                dayTimes: dayTimes,
              ),
              if (_selectedDay.value != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 20.0,
                    ),
                    AndroidHeading(title: 'Select time'),
                    Divider(),
                    if (_selectedTime.value != null)
                      Text(
                        'Selected time: ${_selectedTime.value} hrz',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    BookingTimes(
                      selectTime: (time) {
                        _selectedTime.value = time;
                        _selectedStaffer.value = null;
                      },
                      dayTimes: dayTimes,
                      selectedDay: _selectedDay.value,
                      selectedTime: _selectedTime.value,
                      minimumDuration: minimumDuration,
                      bookings: bookings,
                    ),
                  ],
                ),
              if (_selectedTime.value != null &&
                  CommonUtils().canSelectTime(
                    selectedDay: _selectedDay,
                    dayTimes: dayTimes,
                  ))
                Column(
                  children: [
                    Divider(
                      height: 20.0,
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
              if (_inHouse.value &&
                  CommonUtils().canSelectTime(
                    selectedDay: _selectedDay,
                    dayTimes: dayTimes,
                  ))
                Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    AndroidHeading(title: 'Enter address'),
                    AndroidTextField(
                      prefixIcon: Icons.location_on_outlined,
                      label: 'Address',
                      onInputChange: (input) {
                        _serviceCallAddress.value = input;
                      },
                    ),
                  ],
                ),
              if (CommonUtils().canSelectStaff(
                    inHouse: _inHouse,
                    serviceCallAddress: _serviceCallAddress,
                    selectedTime: _selectedTime,
                  ) &&
                  CommonUtils().canSelectTime(
                    selectedDay: _selectedDay,
                    dayTimes: dayTimes,
                  ))
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 20.0,
                    ),
                    AndroidHeading(title: 'Select staffer'),
                    Divider(),
                    if (_selectedStaffer.value != null)
                      Text(
                        'Selected staffer: ${_selectedStaffer.value}',
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                                        if (_selectedStaffer.value == null) {
                                          _selectedStaffer.value =
                                              staff['fullName'];
                                          _selectedStafferId.value =
                                              staff['id'];
                                        } else {
                                          _selectedStaffer.value = null;
                                          _selectedStafferId.value = null;
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 28,
                                          backgroundColor:
                                              _selectedStaffer.value != null
                                                  ? Theme.of(context)
                                                      .primaryColor
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
                                      staff['fullName']
                                          .toString()
                                          .split(' ')[0],
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
              if (CommonUtils().canBook(
                      inHouse: _inHouse,
                      serviceCallAddress: _serviceCallAddress,
                      selectedDay: _selectedDay,
                      selectedTime: _selectedTime,
                      selectedStaffer: _selectedStaffer) &&
                  CommonUtils().canSelectTime(
                    selectedDay: _selectedDay,
                    dayTimes: dayTimes,
                  ))
                AndroidButton(
                  label: 'Checkout',
                  backgroundColor: Theme.of(context).primaryColor,
                  pressed: () async {
                    _submit(
                      clientBook: runBookMutation
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
