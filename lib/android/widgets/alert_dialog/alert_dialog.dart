import 'package:flutter/material.dart';

class AndroidAlertDialog extends StatelessWidget {
  final String title;
  final Widget message;
  final bool replacePreviousNavigation;
  final String navigateTo;
  final bool fromSignUp;
  final bool fromResendFirstOTP;
  final int tabIndex;
  final int popTimes;

  AndroidAlertDialog({
    this.title,
    this.message,
    this.navigateTo,
    this.replacePreviousNavigation = false,
    this.fromSignUp,
    this.fromResendFirstOTP,
    this.tabIndex,
    this.popTimes = 1,
    Key key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message,
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            if (navigateTo != null) {
              if (replacePreviousNavigation) {
                if (fromSignUp != null && fromSignUp) {
                  Navigator.of(context).pushReplacementNamed(navigateTo,
                      arguments: {'firstTimeSignin': true});
                } else {
                  Navigator.of(context).pushReplacementNamed(navigateTo);
                }
              } else {
                Navigator.of(context).pushNamed(navigateTo);
              }
            } else {
              for(int i = 0; i < popTimes; i++) {
                Navigator.of(context).pop();
              }
            }
          },
        )
      ],
    );
  }
}
