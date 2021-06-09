import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../widgets/checkbox/checkbox.dart';
import '../../../widgets/button/button.dart';

import '../../../../common/utils/utils.dart';

class OperatingTimes extends StatefulWidget {
  OperatingTimes({Key key}) : super(key: key);

  @override
  _OperatingTimeScreenWidgetState createState() =>
      _OperatingTimeScreenWidgetState();
}

class _OperatingTimeScreenWidgetState extends State<OperatingTimes> {
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
        SizedBox(height: 20.0,),
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
        SizedBox(height: 20.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 170.0,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (time) {},
                              currentTime: DateTime.now(),
                            );
                          },
                          child: AutoSizeText('Business starts not set.', softWrap: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 170.0,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (time) {},
                              currentTime: DateTime.now(),
                            );
                          },
                          child: AutoSizeText('Business ends not set.', softWrap: true,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 170.0,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (time) {},
                              currentTime: DateTime.now(),
                            );
                          },
                          child: AutoSizeText('Break starts not set.', softWrap: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 170.0,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (time) {},
                              currentTime: DateTime.now(),
                            );
                          },
                          child: AutoSizeText('Break ends not set.', softWrap: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 170.0,
              child: AndroidButton(
                color: Colors.white,
                label: 'Set',
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              width: 170.0,
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
