import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:groomzy/android/widgets/loading/loading.dart';

import './operating_time.dart';
import './add_operating_time.dart';

import '../../../../../api/graphql/queries/provider/provider_operating_times.dart';

class OperatingTimes extends StatelessWidget {
  final int providerId;

  OperatingTimes({this.providerId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(
          ProviderOperatingTimesQuery().providerOperatingTimes,
        ),
        variables: {'providerId': providerId},
      ),
      builder: (
        QueryResult providerOperatingTimesResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (providerOperatingTimesResult.hasException) {
          if (providerOperatingTimesResult.exception.graphqlErrors.length > 0) {
            errorMessage =
                providerOperatingTimesResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (providerOperatingTimesResult.isLoading) {
          return AndroidLoading();
        }

        Map data = providerOperatingTimesResult.data;
        List dayTimes = [];

        if (data != null && data['providerOperatingTimes'] != null) {
          dayTimes = data['providerOperatingTimes']['dayTimes'] ?? [];
        }

        return RefreshIndicator(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: AddOperatingTime(),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.add_outlined, color: Colors.green),
                    title: Text('Click to add business day'),
                  ),
                ),
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
                if (dayTimes.length < 1)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: Text(
                      'You currently have no business operating times set',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ...dayTimes.map((dayTime) {
                  return OperatingTime(
                    dayTimeId: dayTime['id'],
                    day: dayTime['day']['day'],
                    startTime: dayTime['time']['startTime'],
                    endTime: dayTime['time']['endTime'],
                  );
                }).toList(),
              ],
            ),
          ),
          onRefresh: refetch,
        );
      },
    );
  }
}
