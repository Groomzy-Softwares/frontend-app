import 'package:flutter/material.dart';

import '../../book/main.dart';

class Service extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final int serviceId;

  const Service({
    this.price,
    this.name,
    this.description,
    this.serviceId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          BookScreen.routeName,
          arguments: {
            'name': name,
            'description': description,
            'serviceId': 1,
            'price': price,
          },
        );
      },
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: ListTile(
          title: Text(name),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
            child: Text(description),
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
                    Icon(
                      Icons.chevron_right_outlined,
                      size: 30.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Text('R $price'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
