import 'package:flutter/material.dart';

class TableValue extends StatelessWidget {
  final String value;

  const TableValue({this.value, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
