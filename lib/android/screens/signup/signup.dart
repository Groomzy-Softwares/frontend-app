import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:email_validator/email_validator.dart';

import '../signin/main.dart';
import '../../widgets/text_field/text_field.dart';
import '../../widgets/button/button.dart';
import '../../widgets/checkbox/checkbox.dart';
import '../../widgets/alert_dialog/alert_dialog.dart';
import '../../widgets/loading/loading.dart';
import '../../../common/constants/constants.dart';

import '../../../api/graphql/mutations/client/signup.dart';
import '../../../api/graphql/mutations/provider/provider_signup.dart';

class SignUp extends HookWidget {
  SignUp({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _fullName = useState('');
    final _email = useState('');
    final _phoneNumber = useState('');
    final _password = useState('');
    final _isProvider = useState(false);

    Future<void> _submit({Function signUp}) async {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      await signUp({
        'email': _email.value,
        'fullName': _fullName.value,
        'password': _password.value,
        'phoneNumber': _phoneNumber.value,
      });
    }

    return Container(
      child: Mutation(
        options: MutationOptions(
          document: gql(
            _isProvider.value
                ? SignUpProviderMutation().signupProvider
                : SignUpClientMutation().signupClient,
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
          onCompleted: (dynamic signUpResult) async {
            if (signUpResult != null) {
              print(signUpResult);
              String message =
                  signUpResult[_isProvider.value ? 'signupProvider' : 'signupClient']
                      ['message'];
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
                      navigateTo: SignInScreen.routeName,
                      replacePreviousNavigation: true,
                      fromSignUp: true,
                    );
                  },
                );
              }
            }
          },
        ),
        builder: (
          RunMutation runSignUpMutation,
          QueryResult signUpResult,
        ) {
          if (signUpResult.isLoading) {
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
                  value: _fullName.value,
                  label: 'Full name',
                  prefixIcon: Icons.person_outlined,
                  onInputChange: (input) {
                    _fullName.value = input;
                  },
                  onValidation: (String input) {
                    if (input == null || input.isEmpty) {
                      return 'First name is required';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                AndroidTextField(
                    value: _email.value,
                    label: 'Email',
                    prefixIcon: Icons.email_outlined,
                    onInputChange: (input) {
                      _email.value = input;

                    },
                    onValidation: (String input) {
                      if (input == null || input.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(input.trim())) {
                        return 'Invalid email';
                      }

                      return null;
                    }),
                SizedBox(height: 10.0),
                AndroidTextField(
                    value: _phoneNumber.value,
                    label: 'Phone number',
                    prefixIcon: Icons.phone_android_outlined,
                    onInputChange: (input) {
                      _phoneNumber.value = input;
                    },
                    onValidation: (String input) {
                      if (input == null || input.isEmpty) {
                        return 'Phone number is required';
                      }

                      return null;
                    }),
                SizedBox(height: 10.0),
                AndroidTextField(
                    value: _password.value,
                    label: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.password_outlined,
                    onInputChange: (input) {
                      _password.value = input;
                    },
                    onValidation: (String input) {
                      if (input == null || input.isEmpty) {
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
                  checked: _isProvider.value,
                  onChecked: (checked) {
                    _isProvider.value = checked;
                  },
                ),
                AndroidButton(
                  label: 'Sign up',
                  backgroundColor: Theme.of(context).primaryColor,
                  pressed: () async {
                    _submit(signUp: runSignUpMutation);
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
