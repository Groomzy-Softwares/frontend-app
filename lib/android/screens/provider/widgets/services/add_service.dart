import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/checkbox/checkbox.dart';
import '../../../../widgets/text_field/text_field.dart';
import '../../../../widgets/alert_dialog/alert_dialog.dart';
import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/mutations/service/add_service.dart';

class AddService extends HookWidget {
  AddService({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _title = useState<String>('');
    final _category = useState<String>('');
    final _description = useState<String>('');
    final _price = useState<double>(0.0);
    final _duration = useState<double>(0.0);
    final _durationUnit = useState<String>('');
    final _inHouse = useState<bool>(false);

    Future<void> _submit({Function addService}) async {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      print(_inHouse.value);

      await addService({
        'category': _category.value,
        'title': _title.value,
        'description': _description.value,
        'duration': _duration.value,
        'durationUnit': _durationUnit.value,
        'price': _price.value,
        'inHouse': _inHouse.value,
      });
    }

    return Mutation(
        options: MutationOptions(
          document: gql(
            AddServiceMutation().addService,
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
          onCompleted: (dynamic addServiceResult) async {
            if (addServiceResult != null) {
              String message = addServiceResult['addService']['message'];
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
          RunMutation runAddServiceMutation,
          QueryResult addServiceResult,
        ) {
          if (addServiceResult.isLoading) {
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
                  DropDownFormField(
                    value: _category.value,
                    titleText: 'Category',
                    textField: 'display',
                    valueField: 'value',
                    dataSource: [
                      {
                        "display": "Barber",
                        "value": "Barber",
                      },
                      {
                        "display": "Hairdresser",
                        "value": "Hairdresser",
                      },
                      {
                        "display": "Makeup artist",
                        "value": "Makeup artist",
                      },
                      {
                        "display": "Nail technician",
                        "value": "Nail technician",
                      },
                      {
                        "display": "Spa",
                        "value": "Spa",
                      },
                    ],
                    onChanged: (String input) {
                      _category.value = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Category is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  AndroidTextField(
                    value: _title.value,
                    label: 'title',
                    onInputChange: (String input) {
                      _title.value = input;
                    },
                    onValidation: (String input) {
                      if (input == null || input.isEmpty) {
                        return 'Title is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  AndroidTextField(
                    value: _description.value,
                    label: 'description',
                    onInputChange: (String input) {
                      _description.value = input;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: _price.value.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    cursorColor: Colors.grey,
                    onChanged: (String input) {
                      _price.value = input != null && input.isNotEmpty ? double.parse(input) : 0.0;
                    },
                    validator: (String input) {
                      if (input == null || input.isEmpty) {
                        return 'Price is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: _duration.value.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    cursorColor: Colors.grey,
                    onChanged: (String input) {
                      _duration.value = input != null && input.isNotEmpty ? double.parse(input) : 0.0;
                    },
                    validator: (String input) {
                      if (input == null || input.isEmpty) {
                        return 'Duration is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  DropDownFormField(
                    value: _durationUnit.value,
                    titleText: 'Duration unit',
                    textField: 'display',
                    valueField: 'value',
                    dataSource: [
                      {
                        "display": "Minutes",
                        "value": "min",
                      },
                      {
                        "display": "Hours",
                        "value": "hrz",
                      },
                    ],
                    onChanged: (String input) {
                      _durationUnit.value = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Duration unit is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  AndroidCheckBox(
                    label: 'In house call?',
                    checked: _inHouse.value,
                    onChecked: (bool input) {
                      _inHouse.value = input;
                    },
                  ),
                  AndroidButton(
                    label: 'Add',
                    backgroundColor: Theme.of(context).primaryColor,
                    pressed: () {
                      _submit(addService: runAddServiceMutation);
                    },
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
