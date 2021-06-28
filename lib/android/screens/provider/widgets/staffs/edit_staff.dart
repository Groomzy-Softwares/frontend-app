import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/text_field/text_field.dart';

class EditStaff extends HookWidget {
  final String fullName;

  const EditStaff({
    this.fullName,
    Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fullName = useState<String>('');

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
            AndroidTextField(
              value: _fullName.value ?? fullName,
              label: 'title',
              onInputChange: (String input) {
                _fullName.value = input;
              },
              onValidation: (String input) {
                if (input.isEmpty) {
                  return 'Full name is required';
                }

                return null;
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
