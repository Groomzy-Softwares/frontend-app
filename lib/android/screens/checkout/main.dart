import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:groomzy/android/screens/client/main.dart';
import 'package:groomzy/android/widgets/alert_dialog/alert_dialog.dart';
import 'package:groomzy/api/graphql/mutations/client/book_complete.dart';

import './checkout.dart';
import '../../../common/constants/constants.dart';

class CheckoutScreen extends StatelessWidget {
  static final String routeName = '/${CHECKOUT_TITLE.toLowerCase()}';

  const CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final String name = arguments['name'];
    final String category = arguments['category'];
    final String description = arguments['description'];
    final double price = arguments['price'];
    final int bookingId = arguments['bookingId'];

    return Mutation(
      options: MutationOptions(
        document: gql(ClientBookCompleteMutation().clientBookComplete),
        update: (
          GraphQLDataProxy cache,
          QueryResult result,
        ) {
          if (result.hasException) {
            String errMessage = result.exception.graphqlErrors[0].message;
            print(errMessage);
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
        onCompleted: (dynamic clientBookCompleteResult) async {
          if (clientBookCompleteResult != null) {
            String message =
                clientBookCompleteResult['clientBookComplete']['message'];
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
                    navigateTo: ClientScreen.routeName,
                    replacePreviousNavigation: true,
                  );
                },
              );
            }
          }
        },
      ),
      builder: (
        RunMutation runClientBookCompleteMutation,
        QueryResult clientBookCompleteResult,
      ) {
        return Checkout(
          category: category,
          bookingId: bookingId,
          clientBookCompleteMutation: runClientBookCompleteMutation,
          description: description,
          name: name,
          price: price,
        );
      },
    );
  }
}
