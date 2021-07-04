import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../widgets/rating/rating.dart';
import '../../../widgets/loading/loading.dart';

import '../../../../common/utils/utils.dart';

import '../../../../api/graphql/queries/provider/provider_ratings.dart';

class Reviews extends StatelessWidget {
  final int providerId;

  Reviews({this.providerId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(ProviderRatingsQuery().providerRatings),
        variables: {'providerId': providerId},
      ),
      builder: (
        QueryResult providerRatingsResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (providerRatingsResult.hasException) {
          if (providerRatingsResult.exception.graphqlErrors.length > 0) {
            errorMessage =
                providerRatingsResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (providerRatingsResult.isLoading) {
          return AndroidLoading();
        }

        Map data = providerRatingsResult.data;
        List ratings = [];

        if (data != null && data['providerRatings'] != null) {
          ratings = data['providerRatings']['bookings'] ?? [];
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
                if (ratings.length < 1)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: Text(
                      'No ratings available',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                if (ratings.length > 0)
                  ...ratings.map(
                    (rating) {
                      Map _rating = rating['rating'];
                      Map client = rating['client'];
                      String fullName = client['fullName'];
                      String firstName = fullName.split(' ')[0];
                      String initial = firstName[0].toUpperCase();
                      Map ratingReview =
                          CommonUtils().ratingReview(_rating['rate']);
                      return Column(
                        children: [
                          ListTile(
                            leading: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.black12,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        initial,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(firstName),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6.0,),
                                AndroidRating(
                                  ratingCounts: _rating['rate'].toDouble(),
                                  icon: Icons.star_outline,
                                  iconColor: ratingReview['color'],
                                ),
                                SizedBox(height: 10.0,),
                                Text(
                                  _rating['comment'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                )
                              ],
                            ),
                            trailing: Icon(
                              ratingReview['icon'],
                              color: ratingReview['color'],
                            ),
                          ),
                          Divider(),
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
