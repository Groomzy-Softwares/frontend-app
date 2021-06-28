import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/checkbox/checkbox.dart';
import '../../../../widgets/text_field/text_field.dart';

class EditService extends HookWidget {
  final String title;
  final String description;
  final String category;
  final double price;
  final double duration;
  final String durationUnit;
  final bool inHouse;

  const EditService({
    this.category,
    this.title,
    this.description,
    this.price,
    this.duration,
    this.durationUnit,
    this.inHouse,
    Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _title = useState<String>('');
    final _category = useState<String>('');
    final _description = useState<String>('');
    final _price = useState<double>(0.0);
    final _duration = useState<double>(0.0);
    final _durationUnit = useState<String>('');
    final _inHouse = useState<bool>(false);

    return Container(
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
                _category.value = input;
              },
              validator: (input) {
                if (input.isEmpty) {
                  return 'Category is required';
                }

                return null;
              },
            ),
            SizedBox(height: 10.0),
            AndroidTextField(
              value: _title.value ?? title,
              label: 'title',
              onInputChange: (String input) {
                _title.value = input;
              },
              onValidation: (String input) {
                if (input.isEmpty) {
                  return 'Title is required';
                }

                return null;
              },
            ),
            SizedBox(height: 10.0),
            AndroidTextField(
              value: _description.value ?? description,
              label: 'description',
              onInputChange: (String input) {
                _description.value = input;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: _price.value.toString() ?? price.toString(),
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
                _price.value = double.parse(input);
              },
              validator: (String input) {
                if (input.isEmpty) {
                  return 'Price is required';
                }

                return null;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: _duration.value.toString() ?? duration.toString(),
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
                _duration.value = double.parse(input);
              },
              validator: (String input) {
                if (input.isEmpty) {
                  return 'Duration is required';
                }

                return null;
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
                _durationUnit.value = input;
              },
              validator: (input) {
                if (input.isEmpty) {
                  return 'Duration unit is required';
                }

                return null;
              },
            ),
            SizedBox(height: 10.0),
            AndroidCheckBox(
              label: 'In house call?',
              checked: _inHouse.value ?? inHouse,
              onChecked: (bool input) {
                _inHouse.value = input;
              },
            ),
            AndroidButton(
              label: 'Edit',
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
