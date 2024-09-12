import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Time extends StatelessWidget {
  final String label;
  final String selectedTime;
  final Function setTime;

  const Time({
    this.label,
    this.selectedTime,
    this.setTime,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          DatePicker.showTimePicker(
            context,
            showTitleActions: true,
            showSecondsColumn: false,
            onConfirm: (time) {
              setTime(time);
            },
            currentTime: DateTime.now(),
          );
        },
        child: Row(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10.0,
            ),
            AutoSizeText(
              selectedTime ?? label,
              softWrap: true,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
