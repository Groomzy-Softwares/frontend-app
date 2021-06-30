import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingTimes extends StatelessWidget {
  final Function selectTime;
  final List dayTimes;
  final DateTime selectedDay;
  final int minimumDuration;
  final int duration;

  const BookingTimes({
    this.dayTimes,
    this.selectTime,
    this.selectedDay,
    this.minimumDuration,
    this.duration,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List times() {
      String day =
          DateFormat.yMEd().add_jms().format(selectedDay).split(',')[0];
      Map selectedDayOperatingTime = dayTimes.where((dayTime) {
        return dayTime['day']['day'] == day;
      }).toList()[0]['time'];

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

      int track = 1;
      List _times = [];

      double end = endTimeOfDay.hour + (endTimeOfDay.minute / 60);
      double start = startTimeOfDay.hour + (startTimeOfDay.minute / 60);

      while (end >= start) {
        bool isHour = (track * minimumDuration) % 60 == 0;

        _times.add(
          startTimeOfDay,
        );

        startTimeOfDay = TimeOfDayExtension(startTimeOfDay).add(
          hour: isHour ? 1 : 0,
          minute: isHour ? -minimumDuration : minimumDuration,
        );

        start = startTimeOfDay.hour + (startTimeOfDay.minute / 60);

        track += 1;
      }

      List<List> columns = [];
      int columnCount = -1;
      for (var i = 0; i < _times.length; i++) {
        if (i % 4 == 0) {
          columnCount += 1;
          columns.add([_times[i]]);
        } else {
          columns[columnCount].add(_times[i]);
        }
      }

      return columns;
    }

    return Container(
      height: 80.0,
      padding: EdgeInsets.only(bottom: 5.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...times()
                .map(
                  (row) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...row.map(
                        (rowCell) {
                          return GestureDetector(
                            onTap: () {
                              selectTime('${rowCell.hour}:${rowCell.minute}');
                            },
                            child: Container(
                              height: 50.0,
                              width: 95,
                              child: Card(
                                child: Align(
                                  alignment: Alignment.center,
                                  child:
                                      Text('${rowCell.hour}:${rowCell.minute}'),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                )
                .toList(),
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
