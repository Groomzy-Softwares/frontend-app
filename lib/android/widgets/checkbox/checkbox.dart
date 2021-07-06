import 'package:flutter/material.dart';

class AndroidCheckBox extends StatelessWidget {
  final String label;
  final bool checked;
  final Function onChecked;
  final bool textBelow;
  const AndroidCheckBox({
    this.onChecked,
    this.label,
    this.checked,
    this.textBelow = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textBelow
        ? Column(
            children: [
              Checkbox(
                value: checked,
                onChanged: onChecked,
                checkColor: Colors.white,
                activeColor: Theme.of(context).primaryColor,
              ),
              Text(label),
            ],
          )
        : Row(
            children: [
              Checkbox(
                value: checked,
                onChanged: onChecked,
                checkColor: Colors.white,
                activeColor: Theme.of(context).primaryColor,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          );
  }
}
