import 'package:flutter/material.dart';

import '../../book/main.dart';
import '../../../../common/constants/constants.dart';

class AndroidService extends StatelessWidget {
  const AndroidService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(BookScreen.routeName);
      },
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.image_outlined, size: 30),
          ),
          title: Text('Title'),
          subtitle: Text(
            'description of the service description description '
            'description description description',
          ),
          trailing: Container(
            // height: 80,
            width: 70.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Book',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                    Icon(Icons.chevron_right_outlined),
                  ],
                ),
                SizedBox(height: 5.0),
                Text('R200')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
