import 'package:flutter/material.dart';

import 'service.dart';

class Services extends StatelessWidget {
  final int providerId;
  final List services;
  final List staffs;

  const Services({
    this.providerId,
    this.staffs,
    this.services,
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
                ),
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
