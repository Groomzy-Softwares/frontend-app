import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class OperatingTime extends StatelessWidget {
  final String selectedTime;
  const OperatingTime({this.selectedTime, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.0,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              DatePicker.showTime12hPicker(
                context,
                showTitleActions: true,
                onConfirm: (time) {},
                currentTime: DateTime.now(),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 22.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 5.0,),
                AutoSizeText(selectedTime,
                      softWrap: true, style: TextStyle(fontSize: 15.0),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
