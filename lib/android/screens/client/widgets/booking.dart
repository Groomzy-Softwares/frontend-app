import 'package:flutter/material.dart';
import 'package:groomzy/android/widgets/button/button.dart';

class Booking extends StatelessWidget {
  const Booking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Title'),
              subtitle: Column(
                children: [
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      Text('Date: '),
                      Text('2021/10/11')
                    ],
                  ),
                  Row(
                    children: [
                      Text('Time: '),
                      Text('16:99 hrz')
                    ],
                  ),
                  Row(
                    children: [
                      Text('Price: '),
                      Text('R200.0')
                    ],
                  ),
                  Row(
                    children: [
                      Text('InHouse call: '),
                      Text('No')
                    ],
                  ),
                ],
              ),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.45,
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
