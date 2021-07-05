import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final String header;

  const TableHeader({this.header, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        header,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
