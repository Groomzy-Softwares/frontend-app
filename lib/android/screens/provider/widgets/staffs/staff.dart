import 'package:flutter/material.dart';

import './edit_staff.dart';
import './delete_staff.dart';

class Staff extends StatelessWidget {
  final String fullName;
  final int staffId;

  const Staff({
    this.fullName,
    @required this.staffId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 0.5,
      child: Column(
        children: [
          Divider(height: 0.0,),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0,),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Name'),
              subtitle: Text(fullName),
              trailing: Container(
                width: 120.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: EditStaff(
                                staffId: staffId,
                                fullName: fullName,
                              ),
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
                            return DeleteStaff(staffId: staffId,);
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
        ],
      ),
    );
  }
}
