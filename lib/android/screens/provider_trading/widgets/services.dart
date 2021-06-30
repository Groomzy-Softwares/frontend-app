import 'package:flutter/material.dart';

import 'service.dart';

class Services extends StatelessWidget {
  final int providerId;
  final int minimumDuration;
  final List services;
  final List staffs;
  final List dayTimes;

  const Services({
    this.providerId,
    this.staffs,
    this.services,
    this.dayTimes,
    this.minimumDuration,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...services
              .map(
                (service) => Column(
                  children: [
                    Service(
                        serviceId: service['id'],
                        name: service['title'],
                        description: service['description'],
                        price: double.parse(service['price'].toString()),
                        staffs: staffs,
                        dayTimes: dayTimes,
                        duration: service['duration'],
                        minimumDuration: minimumDuration),
                    Divider(),
                  ],
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
