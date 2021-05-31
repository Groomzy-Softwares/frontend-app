import 'package:flutter/material.dart';

import '../../widgets/text_field/text_field.dart';
import '../../widgets/button/button.dart';
import '../../../common/constants/constants.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isProvider = false;
    return Container(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              LOGO_IMAGE,
              fit: BoxFit.cover,
              height: 80,
            ),
          ),
          SizedBox(height: 20.0),
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
            title: Text('Signing in as a service provider?'),
          ),
          SizedBox(
            height: 10.0,
          ),
          AndroidButton(
            label: 'Sign in',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
