import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:groomzy/android/widgets/loading/loading.dart';
import 'package:groomzy/api/graphql/queries/provider/provider_bookings.dart';
import 'package:intl/intl.dart';

import 'booking.dart';

class Bookings extends StatelessWidget {
  final int providerId;

  const Bookings({this.providerId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(ProviderBookingsQuery().providerBookings),
          variables: {'providerId': providerId}),
      builder: (
        QueryResult providerBookingsResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (providerBookingsResult.hasException) {
          if (providerBookingsResult.exception.graphqlErrors.length > 0) {
            errorMessage =
                providerBookingsResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (providerBookingsResult.isLoading) {
          return AndroidLoading();
        }

        Map data = providerBookingsResult.data;
        List bookings = [];

        if (data != null && data['providerBookings'] != null) {
          bookings = data['providerBookings']['bookings'] ?? [];
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
                      Map client = booking['client'];
                      int parsedBookingTime = int.parse(booking['bookingTime']);
                      DateTime bookingTime =
                          DateTime.fromMillisecondsSinceEpoch(
                        parsedBookingTime,
                      );
                      return Column(
                        children: [
                          Booking(
                            bookingId: booking['id'],
                            bookedBy: client['fullName'],
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
