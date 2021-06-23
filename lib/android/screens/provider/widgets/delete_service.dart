import 'package:flutter/material.dart';

class DeleteService extends StatelessWidget {
  final int serviceId;

  const DeleteService({this.serviceId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please confirm'),
      content: Text('Are you sure want to delete?'),
      actions: <Widget>[
        TextButton(
          child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
          onPressed: () {
            print('Confirmed');
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Colors.amber),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
