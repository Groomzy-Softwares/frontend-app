import 'package:flutter/material.dart';

import './edit_service.dart';
import './delete_service.dart';

class Service extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final double price;
  final int serviceId;

  const Service({
    this.price,
    this.name,
    this.description,
    this.category,
    this.serviceId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 0.5,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(name),
          subtitle: Table(
            children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    'Duration',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    'In-house',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Divider(),
                ),
                TableCell(
                  child: Divider(),
                ),
                TableCell(
                  child: Divider(),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Text(
                    'R200',
                  ),
                ),
                TableCell(
                  child: Text(
                    '45 min',
                  ),
                ),
                TableCell(
                  child: Text(
                    'Yes',
                  ),
                ),
              ])
            ],
          ),
          trailing: Container(
            width: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: EditService(),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.amber,
                  ),
                ),
                VerticalDivider(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteService(serviceId: serviceId);
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
