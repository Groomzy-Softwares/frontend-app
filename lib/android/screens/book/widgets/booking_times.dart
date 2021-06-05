import 'package:flutter/material.dart';

class BookingTimes extends StatelessWidget {
  final Function selectTime;
  final List<String> times;

  const BookingTimes({this.times, this.selectTime, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<String>> columns = [];
    int columnCount = -1;
    for (var i = 0; i < times.length; i++) {
      if (i % 4 == 0) {
        columnCount += 1;
        columns.add([times[i]]);
      }
      else {
        columns[columnCount].add(times[i]);
      }
    }

    return Card(
      child: Column(
        children: columns
            .map(
              (columnRows) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: columnRows
                    .map(
                      (columnRow) => GestureDetector(
                        onTap: () {
                          selectTime(columnRow);
                        },
                        child: Container(
                          height: 50.0,
                          width: 80,
                          child: Card(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(columnRow),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
