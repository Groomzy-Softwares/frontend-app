import 'package:flutter/material.dart';

import './edit_operating_times.dart';
import './delete_operating_time.dart';

class OperatingTime extends StatelessWidget {
  final int dayTimeId;
  final String day;
  final String startTime;
  final String endTime;

  const OperatingTime({
    this.dayTimeId,
    this.day,
    this.startTime,
    this.endTime,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 0.5,
      child: Column(
        children: [
          Divider(height: 0.0,),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0,),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              subtitle: Table(
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Text(
                        'Day',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Start time',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'End time',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Divider(),
                    ),
                    TableCell(
                      child: Divider(),
                    ),
                    TableCell(
                      child: Divider(),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Text(
                        day,
                      ),
                    ),
                    TableCell(
                      child: Text(
                        startTime,
                      ),
                    ),
                    TableCell(
                      child: Text(
                        endTime,
                      ),
                    ),
                  ])
                ],
              ),
              trailing: Container(
                padding: EdgeInsets.only(top: 10.0),
                width: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: EditOperatingTime(
                                dayTimeId: dayTimeId,
                                day: day,
                                startTime: startTime,
                                endTime: endTime,
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    VerticalDivider(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteOperatingTime(
                              dayTimeId: dayTimeId,
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    );
  }
}
