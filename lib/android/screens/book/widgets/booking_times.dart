import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingTimes extends StatelessWidget {
  final Function selectTime;
  final List dayTimes;
  final DateTime selectedDay;
  final String selectedTime;
  final int minimumDuration;
  final int duration;
  final List bookings;

  const BookingTimes({
    this.dayTimes,
    this.selectTime,
    this.selectedDay,
    this.selectedTime,
    this.minimumDuration,
    this.duration,
    this.bookings,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<Map>> times() {
      String day =
          DateFormat.yMEd().add_jms().format(selectedDay).split(',')[0];
      List selectedDayOperating = dayTimes.where((dayTime) {
        return dayTime['day']['day'] == day;
      }).toList();

      Map selectedDayOperatingTime;

      if (selectedDayOperating.length < 1) {
        return [];
      }

      selectedDayOperatingTime = selectedDayOperating[0]['time'];

      String startTime = selectedDayOperatingTime['startTime'];
      String endTime = selectedDayOperatingTime['endTime'];

      TimeOfDay startTimeOfDay = TimeOfDay(
        hour: int.parse(startTime.split(':')[0]),
        minute: int.parse(startTime.split(':')[1]),
      );

      TimeOfDay endTimeOfDay = TimeOfDay(
        hour: int.parse(endTime.split(':')[0]),
        minute: int.parse(endTime.split(':')[1]),
      );

      List<TimeOfDay> _times = [];

      double end = endTimeOfDay.hour + (endTimeOfDay.minute / 60);
      double start = startTimeOfDay.hour + (startTimeOfDay.minute / 60);

      while (end >= start) {
        bool isHour = (startTimeOfDay.minute + minimumDuration) % 60 == 0;

        _times.add(
          startTimeOfDay,
        );

        startTimeOfDay = TimeOfDayExtension(startTimeOfDay).add(
          hour: isHour ? 1 : 0,
          minute: isHour ? -startTimeOfDay.minute : minimumDuration,
        );

        start = startTimeOfDay.hour + (startTimeOfDay.minute / 60);
      }

      List bookedTimes = [];

      _times.forEach((time) {
        bookings.where((booking) {
          DateTime bookingDate = DateTime.fromMillisecondsSinceEpoch(
              int.parse(booking['bookingTime']));
          String bookingDay =
              DateFormat.yMEd().add_jms().format(bookingDate).split(',')[0];
          return bookingDay == day;
        }).forEach((booking) {
          DateTime bookingDate = DateTime.fromMillisecondsSinceEpoch(
              int.parse(booking['bookingTime']));

          Map service = booking['service'];
          bool isHours = service['durationUnit'] == 'hrz';
          double durationInMinutes =
              isHours ? service['duration'] * 60 : service['duration'] + 0.0;

          String strBookingTime = DateFormat().add_Hm().format(bookingDate);
          TimeOfDay bookingTime = TimeOfDay(
            hour: int.parse(strBookingTime.split(':')[0]),
            minute: int.parse(strBookingTime.split(':')[1]),
          );
          TimeOfDay bookingDurationTime = TimeOfDay(
            hour: bookingTime.hour + (durationInMinutes / 60).floor(),
            minute: bookingTime.minute + (durationInMinutes % 60).floor(),
          );

          if (time == bookingTime) {
            bookedTimes.add(time);
          } else if ((time.hour * 60 + time.minute >=
                  (bookingTime.hour * 60 + bookingTime.minute)) &&
              (time.hour * 60 + time.minute) <
                  (bookingDurationTime.hour * 60 +
                      bookingDurationTime.minute)) {
            bookedTimes.add(time);
          }
        });
      });

      List<Map> mapTimes = _times.map((time) {
        if (bookedTimes.where((bookedTime) => bookedTime == time).length > 0) {
          return {
            'occupied': true,
            'time': time,
          };
        }

        return {
          'occupied': false,
          'time': time,
        };
      }).toList();

      List<List<Map>> twoDList = [];
      int columnCount = -1;
      for (var i = 0; i < mapTimes.length; i++) {
        if (i % 4 == 0) {
          columnCount += 1;
          twoDList.add([mapTimes[i]]);
        } else {
          twoDList[columnCount].add(mapTimes[i]);
        }
      }

      return twoDList;
    }

    return Container(
      height: 130.0,
      padding: EdgeInsets.only(bottom: 5.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            if (times().length < 1)
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Sorry, we are not operating on that day\n\n'
                  'Please choose one of the operating days listed',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.orange,
                  ),
                ),
              ),
            ...times().map((columns) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...columns.map((time) {
                    TimeOfDay _time = time['time'];
                    bool occupied = time['occupied'];
                    return GestureDetector(
                      onTap: () {
                        if (!occupied) {
                          if (selectedTime == '${_time.hour}:${_time.minute}') {
                            selectTime(null);
                          } else {
                            selectTime('${_time.hour}:${_time.minute}');
                          }
                        }
                      },
                      child: Container(
                        height: 50.0,
                        width: 95,
                        child: Card(
                          elevation:
                              selectedTime == '${_time.hour}:${_time.minute}' &&
                                      !occupied
                                  ? 4
                                  : 0,
                          shadowColor:
                              selectedTime == '${_time.hour}:${_time.minute}' &&
                                      !occupied
                                  ? Theme.of(context).primaryColor
                                  : null,
                          color: occupied
                              ? Colors.grey.shade300
                              : selectedTime == '${_time.hour}:${_time.minute}'
                                  ? null
                                  : null,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${_time.hour}:${_time.minute}',
                              style: TextStyle(
                                color: selectedTime ==
                                            '${_time.hour}:${_time.minute}' &&
                                        !occupied
                                    ? Theme.of(context).primaryColor
                                    : null,
                                fontWeight: selectedTime ==
                                            '${_time.hour}:${_time.minute}' &&
                                        !occupied
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                fontSize: selectedTime ==
                                            '${_time.hour}:${_time.minute}' &&
                                        !occupied
                                    ? 18.0
                                    : 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return this.replacing(hour: this.hour + hour, minute: this.minute + minute);
  }
}
