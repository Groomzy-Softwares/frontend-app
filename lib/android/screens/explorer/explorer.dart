import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './widgets/summary_service_provider.dart';
import '../../widgets/horizontal_scroll/category_labels.dart';
import '../../widgets/loading/loading.dart';

import '../../../api/graphql/queries/provider/providers.dart';
import '../../../api/utils/utils.dart';

class Explore extends StatelessWidget {
  const Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('');
    return Query(
      options: QueryOptions(document: gql(ProvidersQuery().providers)),
      builder: (
        QueryResult providersResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (providersResult.hasException) {
          if (providersResult.exception.graphqlErrors.length > 0) {
            errorMessage = providersResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (providersResult.isLoading) {
          return AndroidLoading();
        }

        Map data = providersResult.data;
        List providers = [];

        if (data != null && data['providers'] != null) {
          providers = providersResult.data['providers'];
        }

        return RefreshIndicator(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                AndroidCategoryLabels(),
                Divider(),
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
                if (providers.length < 1)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: Text(
                      'No providers available',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                if (providers.length > 0)
                  ...providers.map(
                    (provider) {
                      // print(provider);
                      Map providerDetails =
                          APIUtils().getProviderProperties(provider);

                      return AndroidSummaryService(
                        id: providerDetails["id"],
                        categories: providerDetails['categories'],
                        address: providerDetails['address'],
                        name: providerDetails['name'],
                        services: providerDetails['services'],
                        ratings: providerDetails['ratings'],
                        staffs: providerDetails['staffs'],
                        dayTimes: providerDetails['dayTimes'],
                        minimumDuration: providerDetails['minimumDuration'],
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
