import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/text_field/text_field.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../widgets/alert_dialog/alert_dialog.dart';

import '../../../../../api/graphql/mutations/staff/edit_staff.dart';

class EditStaff extends HookWidget {
  final int staffId;
  final String fullName;

  EditStaff({
    @required this.staffId,
    this.fullName,
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _fullName = useState<String>(null);

    Future<void> _submit({Function editStaff}) async {
      if (!formKey.currentState.validate()) {
        return;
      }
      formKey.currentState.save();

      await editStaff({
        'staffId': staffId,
        'fullName': _fullName.value,
      });
    }

    return Mutation(
      options: MutationOptions(
        document: gql(EditStaffMutation().editStaff),
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
        onCompleted: (dynamic editStaffResult) async {
          if (editStaffResult != null) {
            String message = editStaffResult['editStaff']['message'];
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
        RunMutation runEditStaffMutation,
        QueryResult editStaffResult,
      ) {
        if (editStaffResult.isLoading) {
          return AndroidLoading();
        }
        return Form(
          key: formKey,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 500.0,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  AndroidTextField(
                    value: _fullName.value ?? fullName,
                    label: 'title',
                    onInputChange: (String input) {
                      _fullName.value = input;
                    },
                  ),
                  AndroidButton(
                    label: 'Edit',
                    backgroundColor: Theme.of(context).primaryColor,
                    pressed: () {
                      _submit(editStaff: runEditStaffMutation);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
