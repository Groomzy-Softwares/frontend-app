import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/checkbox/checkbox.dart';
import '../../../../widgets/text_field/text_field.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../widgets/alert_dialog/alert_dialog.dart';

import '../../../../../api/graphql/mutations/service/edit_service.dart';

class EditService extends HookWidget {
  final int serviceId;
  final String title;
  final String description;
  final String category;
  final double price;
  final double duration;
  final String durationUnit;
  final bool inHouse;

  EditService({
    @required this.serviceId,
    this.category,
    this.title,
    this.description,
    this.price,
    this.duration,
    this.durationUnit,
    this.inHouse,
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _title = useState<String>(null);
    final _category = useState<String>(null);
    final _description = useState<String>(null);
    final _price = useState<double>(null);
    final _duration = useState<double>(null);
    final _durationUnit = useState<String>(null);
    final _inHouse = useState<bool>(null);

    Future<void> _submit({Function editService}) async {
      if (!formKey.currentState.validate()) {
        return;
      }
      formKey.currentState.save();

      await editService({
        'serviceId': serviceId,
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
            EditServiceMutation().editService,
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
          onCompleted: (dynamic editServiceResult) async {
            if (editServiceResult != null) {
              String message = editServiceResult['editService']['message'];
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
          RunMutation runEditServiceMutation,
          QueryResult editServiceResult,
        ) {
          if (editServiceResult.isLoading) {
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
                          FontAwesomeIcons.times,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    DropDownFormField(
                      value: _category.value ?? category,
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
                        _category.value = input != null ? input : null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    AndroidTextField(
                      value: _title.value ?? title,
                      label: 'title',
                      onInputChange: (String input) {
                        _title.value = input != null ? input : null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    AndroidTextField(
                      value: _description.value ?? description,
                      label: 'description',
                      onInputChange: (String input) {
                        _description.value = input != null ? input : null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _price.value != null ? _price.value.toString() : price.toString(),
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
                        _price.value = input != null ? double.parse(input) : null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _duration.value != null ? _duration.value.toString() : duration.toString(),
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
                        _duration.value = input != null ? double.parse(input) : null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    DropDownFormField(
                      value: _durationUnit.value ?? durationUnit,
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
                        _durationUnit.value = input != null ? input : null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    AndroidCheckBox(
                      label: 'In house call?',
                      checked: _inHouse.value ?? inHouse,
                      onChecked: (bool input) {
                        _inHouse.value = input != null ? input : null;
                      },
                    ),
                    AndroidButton(
                      label: 'Edit',
                      backgroundColor: Theme.of(context).primaryColor,
                      pressed: () {
                        _submit(editService: runEditServiceMutation);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
