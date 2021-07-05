import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import './booking.dart';
import '../../../widgets/loading/loading.dart';

import '../../../../api/graphql/queries/client/client_bookings.dart';

class Bookings extends StatelessWidget {
  final int clientId;

  const Bookings({this.clientId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(ClientBookingsQuery().clientBookings),
        variables: {'clientId': clientId},
      ),
      builder: (
        QueryResult clientBookingsResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (clientBookingsResult.hasException) {
          if (clientBookingsResult.exception.graphqlErrors.length > 0) {
            errorMessage =
                clientBookingsResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (clientBookingsResult.isLoading) {
          return AndroidLoading();
        }

        Map data = clientBookingsResult.data;
        List bookings = [];

        if (data != null && data['clientBookings'] != null) {
          bookings = data['clientBookings']['bookings'] ?? [];
        }

        return RefreshIndicator(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                if (errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                if (bookings.length < 1)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: Text(
                      'No bookings available',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                if (bookings.length > 0)
                  ...bookings.map(
                        (booking) {
                      Map provider = booking['provider'];
                      int parsedBookingTime = int.parse(booking['bookingTime']);
                      DateTime bookingTime =
                      DateTime.fromMillisecondsSinceEpoch(
                        parsedBookingTime,
                      );
                      return Column(
                        children: [
                          Booking(
                            bookingId: booking['id'],
                            provider: provider['fullName'],
                            bookingDate: DateFormat.yMd().format(bookingTime),
                            bookingTime: DateFormat.Hm().format(bookingTime),
                            inHouse: booking['inHouse'],
                            service: booking['service'],
                          ),
                          SizedBox(height: 10.0,),
                        ],
                      );
                    },
                  ).toList(),
              ],
            ),
          ),
          onRefresh: refetch,
        );
      },
    );
  }
}
