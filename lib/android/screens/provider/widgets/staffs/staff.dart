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
      child: Container(
        margin: EdgeInsets.all(10.0),
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
    );
  }
}
