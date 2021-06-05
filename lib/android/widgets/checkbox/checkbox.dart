import 'package:flutter/material.dart';

class AndroidCheckBox extends StatelessWidget {
  final String label;
  final bool checked;
  final Function onChecked;
  const AndroidCheckBox({this.onChecked, this.label, this.checked, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: onChecked,
          checkColor: Colors.white,
          activeColor: Theme.of(context).primaryColor,
        ),
        Text(label),
      ],
    );
  }
}
