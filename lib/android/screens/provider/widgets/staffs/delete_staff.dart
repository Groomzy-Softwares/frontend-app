import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../widgets/alert_dialog/alert_dialog.dart';
import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/mutations/staff/delete_staff.dart';

class DeleteStaff extends StatelessWidget {
  final int staffId;

  const DeleteStaff({@required this.staffId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _submit({Function deleteStaff}) async {
      await deleteStaff({
        'staffId': staffId,
      });
    }
    return AlertDialog(
      title: Text('Please confirm'),
      content: Text('Are you sure want to delete staff?'),
      actions: <Widget>[
        Mutation(
          options: MutationOptions(
            document: gql(
              DeleteStaffMutation().deleteStaff,
            ),
            update: (
                GraphQLDataProxy cache,
                QueryResult result,
                ) {
              if (result.hasException) {
                String errMessage = result.exception.toString();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AndroidAlertDialog(
                      title: 'Error',
                      message: Text(
                        errMessage,
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                      popTimes: 2,
                    );
                  },
                );
              }
              return cache;
            },
            onCompleted: (dynamic deleteStaffResult) async {
              if (deleteStaffResult != null) {
                String message = deleteStaffResult['deleteStaff']['message'];
                if (message.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AndroidAlertDialog(
                        title: 'Completed',
                        message: Text(
                          message,
                          style: TextStyle(
                            color: Colors.lightGreen,
                          ),
                        ),
                        popTimes: 2,
                      );
                    },
                  );
                }
              }
            },
          ),
          builder: (
            RunMutation runDeleteStaffMutation,
            QueryResult deleteStaffResult,
          ) {
            if (deleteStaffResult.isLoading) {
              return AndroidLoading();
            }

            return TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                _submit(deleteStaff: runDeleteStaffMutation);
              },
            );
          },
        ),
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.amber),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
