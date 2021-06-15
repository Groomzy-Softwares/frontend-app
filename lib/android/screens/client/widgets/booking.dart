import 'package:flutter/material.dart';
import 'package:groomzy/android/widgets/button/button.dart';

class Booking extends StatelessWidget {
  const Booking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(5.0),
              title: Text('Title'),
              subtitle: Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Table(
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          'Provider',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Time',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text('Sifiso Myeza'),
                      ),
                      TableCell(
                        child: Text('2021/10/11'),
                      ),
                      TableCell(
                        child: Text('04:00 pm'),
                      ),
                    ]),
                  ],
                ),
              ),
              trailing: Container(
                width: 90.0,
                margin: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.remove_red_eye_outlined, color: Colors.blue,),
                        Text('View'),
                      ],
                    ),
                    VerticalDivider(),
                    Column(
                      children: [
                        Icon(Icons.cancel_outlined, color: Colors.redAccent,),
                        Text('Cancel'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
