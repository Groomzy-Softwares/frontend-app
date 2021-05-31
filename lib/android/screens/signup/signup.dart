import 'package:flutter/material.dart';

import '../../widgets/text_field/text_field.dart';
import '../../widgets/button/button.dart';
import '../../../common/constants/constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isProvider = false;
    return Container(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/common/images/$LOGO_IMAGE',
              fit: BoxFit.cover,
              height: 80,
            ),
          ),
          SizedBox(height: 20.0),
          AndroidTextField(
            label: 'First name',
            prefixIcon: Icons.person_outlined,
          ),
          SizedBox(height: 10.0),
          AndroidTextField(
            label: 'Last name',
            prefixIcon: Icons.person,
          ),
          SizedBox(height: 10.0),
          AndroidTextField(
            label: 'Email',
            prefixIcon: Icons.email_outlined,
          ),
          SizedBox(height: 10.0),
          AndroidTextField(
            label: 'Password',
            prefixIcon: Icons.password_outlined,
          ),
          SizedBox(height: 10.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
              value: isProvider,
              onChanged: (v) {
                isProvider = v;
              },
            ),
            title: Text('Signing up as a service provider?'),
          ),
          AndroidButton(
            label: 'Sign up',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
