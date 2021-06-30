import 'package:flutter/material.dart';

import 'operating_time.dart';
import '../../../../widgets/checkbox/checkbox.dart';
import '../../../../widgets/button/button.dart';

import '../../../../../common/utils/utils.dart';

class OperatingTimes extends StatefulWidget {
  OperatingTimes({Key key}) : super(key: key);

  @override
  _OperatingTimeState createState() => _OperatingTimeState();
}

class _OperatingTimeState extends State<OperatingTimes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Days',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...CommonUtils()
                    .weekDays()
                    .map(
                      (weekDay) => AndroidCheckBox(
                        label: weekDay,
                        onChecked: (input) {},
                        checked: false,
                        textBelow: true,
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
        Divider(
          height: 50.0,
        ),
        Text(
          'Times',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OperatingTime(selectedTime: 'Start time not set.',),
            OperatingTime(selectedTime: 'End time not set.',),
          ],
        ),
        Divider(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 180.0,
              child: AndroidButton(
                color: Colors.white,
                label: 'Set',
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              width: 180.0,
              child: AndroidButton(
                color: Colors.white,
                label: 'Reset',
                backgroundColor: Colors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
