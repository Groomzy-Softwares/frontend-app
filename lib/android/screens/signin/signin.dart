import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../client/main.dart';
import '../provider/main.dart';
import '../../widgets/alert_dialog/alert_dialog.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/text_field/text_field.dart';
import '../../widgets/button/button.dart';
import '../../widgets/checkbox/checkbox.dart';
import '../../../common/constants/constants.dart';

import '../../../api/utils/utils.dart';
import '../../../api/graphql/mutations/signin/client_signin.dart';
import '../../../api/graphql/mutations/signin/provider_signin.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  bool _isProvider = false;

  Future<void> _submit({Function signIn}) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await signIn({
      'email': _email,
      'password': _password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Mutation(
        options: MutationOptions(
          document: gql(
            _isProvider
                ? SignInProviderMutation().signinProvider
                : SignInClientMutation().signinClient,
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
                  );
                },
              );
            }
            return cache;
          },
          onCompleted: (dynamic signInResult) async {
            if (signInResult != null) {
              print(signInResult);
              Map signedIn =
                  signInResult[_isProvider ? 'signinProvider' : 'signinClient'];
              String token = signedIn['token'];
              if (token.isNotEmpty) {
                Map user = {
                  'id': signedIn['id'],
                  'email': signedIn['email'],
                  'fullName': signedIn['fullName'],
                  'phoneNumber': signedIn['phoneNumber'],
                  'role': signedIn['role'],
                };
                await AuthUtil().setToken(token);

                await AuthUtil().setUser(jsonEncode(user));

                Navigator.of(context).pushReplacementNamed(
                    _isProvider ? ProviderScreen.routeName : ClientScreen.routeName,);
              }
            }
          },
        ),
        builder: (RunMutation runSignInMutation,
            QueryResult signInResult,) {
          if (signInResult.isLoading) {
            return AndroidLoading();
          }
          return Form(
            key: _formKey,
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
                    value: _email,
                    label: 'Email',
                    prefixIcon: Icons.email_outlined,
                    onInputChange: (input) {
                      setState(() {
                        _email = input == '' ? null : input;
                      });
                    },
                    onValidation: (String input) {
                      if (input.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(input.trim())) {
                        return 'Invalid email';
                      }

                      return null;
                    }),
                SizedBox(height: 10.0),
                AndroidTextField(
                    value: _password,
                    label: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.password_outlined,
                    onInputChange: (input) {
                      setState(() {
                        _password = input == '' ? null : input;
                      });
                    },
                    onValidation: (String input) {
                      if (input.isEmpty) {
                        return 'Password is required';
                      }
                      if (input.length < 5) {
                        return 'Password should be at least 5 characters.';
                      }

                      return null;
                    }),
                SizedBox(height: 10.0),
                AndroidCheckBox(
                  label: 'Signing up as a service provider?',
                  checked: _isProvider,
                  onChecked: (checked) {
                    setState(() {
                      _isProvider = checked;
                    });
                  },
                ),
                AndroidButton(
                  label: 'Sign in',
                  backgroundColor: Theme.of(context).primaryColor,
                  pressed: () async {
                    _submit(signIn: runSignInMutation);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
