import 'package:flutter/material.dart';

import '../../book/main.dart';

class Service extends StatelessWidget {
  final int providerId;
  final String name;
  final String description;
  final double price;
  final int serviceId;
  final int minimumDuration;
  final int duration;
  final List staffs;
  final List dayTimes;
  final List bookings;

  const Service({
    this.providerId,
    this.price,
    this.name,
    this.description,
    this.serviceId,
    this.staffs,
    this.dayTimes,
    this.minimumDuration,
    this.duration,
    this.bookings,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          BookScreen.routeName,
          arguments: {
            'providerId': providerId,
            'name': name,
            'description': description,
            'serviceId': serviceId,
            'price': price,
            'staffs': staffs,
            'dayTimes': dayTimes,
            'minimumDuration': minimumDuration,
            'duration': duration,
            'bookings': bookings,
          },
        );
      },
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: ListTile(
          title: Text(name),
          subtitle: Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: Text(description),
          ),
          trailing: Container(
            // height: 80,
            width: 130.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R$price',
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
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
                Text('duration $duration'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
