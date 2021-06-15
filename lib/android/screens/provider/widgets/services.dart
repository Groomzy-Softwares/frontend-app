import 'package:flutter/material.dart';

import './service.dart';

class Services extends StatelessWidget {
  const Services({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List services = [
      {
        'id': 1,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 2,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 3,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 4,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 5,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 6,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 7,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 8,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 9,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
      {
        'id': 10,
        'name': 'Title',
        'description': 'description of the service description description '
            'description description description',
        'price': '200',
      },
    ];

    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.add_outlined, color: Colors.green),
              title: Text('Click to add new service'),
            ),
          ),
          ...services
              .map(
                (service) => Column(
                  children: [
                    Service(
                      serviceId: service['id'],
                      name: service['name'],
                      description: service['description'],
                      price: double.parse(service['price']),
                      category: service['category'],
                    ),
                    Divider(),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
