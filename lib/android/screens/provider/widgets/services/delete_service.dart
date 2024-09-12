import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../widgets/alert_dialog/alert_dialog.dart';
import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/mutations/service/delete_service.dart';

class DeleteService extends StatelessWidget {
  final int serviceId;
  final String category;

  const DeleteService({
    @required this.serviceId,
    @required this.category,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _submit({Function deleteService}) async {
      await deleteService({
        'serviceId': serviceId,
        'category': category,
      });
    }

    return AlertDialog(
      title: Text('Please confirm'),
      content: Text('Are you sure want to delete service?'),
      actions: <Widget>[
        Mutation(
          options: MutationOptions(
            document: gql(
              DeleteServiceMutation().deleteService,
            ),
            update: (
              GraphQLDataProxy cache,
              QueryResult result,
            ) {
              if (result.hasException) {
                String errMessage = result.exception.graphqlErrors[0].message;
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
            onCompleted: (dynamic deleteServiceResult) async {
              if (deleteServiceResult != null) {
                String message =
                    deleteServiceResult['deleteService']['message'];
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
            RunMutation runDeleteServiceMutation,
            QueryResult deleteServiceResult,
          ) {
            if (deleteServiceResult.isLoading) {
              return AndroidLoading();
            }

            return TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                _submit(deleteService: runDeleteServiceMutation);
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
