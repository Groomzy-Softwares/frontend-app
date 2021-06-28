import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/text_field/text_field.dart';
import '../../../../widgets/alert_dialog/alert_dialog.dart';
import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/mutations/staff/add_staff.dart';


class AddStaff extends HookWidget {
  AddStaff({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _fullName = useState<String>('');

    Future<void> _submit({Function addStaff}) async {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      await addStaff({
        'fullName': _fullName.value,
      });
    }

    return Mutation(
      options: MutationOptions(
        document: gql(
          AddStaffMutation().addStaff,
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
        onCompleted: (dynamic addStaffResult) async {
          if (addStaffResult != null) {
            String message = addStaffResult['addStaff']['message'];
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
        RunMutation runAddStaffMutation,
        QueryResult addStaffResult,
      ) {
        if (addStaffResult.isLoading) {
          return AndroidLoading();
        }

        return Form(
          key: _formKey,
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
                        FontAwesomeIcons.times,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  AndroidTextField(
                    value: _fullName.value,
                    label: 'Full name',
                    onInputChange: (String input) {
                      _fullName.value = input;
                    },
                    onValidation: (String input) {
                      if (input == null || input.isEmpty) {
                        return 'Full name is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  AndroidButton(
                    label: 'Add',
                    backgroundColor: Theme.of(context).primaryColor,
                    pressed: () {
                      _submit(addStaff: runAddStaffMutation);
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
