import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'service.dart';
import 'add_service.dart';

import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/queries/provider/provider_services.dart';

class Services extends StatelessWidget {
  final int providerId;
  const Services({this.providerId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(ProviderServicesQuery().providerServices),
          variables: {'providerId': providerId}),
      builder: (
        QueryResult providerServicesResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (providerServicesResult.hasException) {
          if (providerServicesResult.exception.graphqlErrors.length > 0) {
            errorMessage =
                providerServicesResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (providerServicesResult.isLoading) {
          return AndroidLoading();
        }

        Map data = providerServicesResult.data;
        List services = [];

        if (data != null && data['providerServices'] != null) {
          services =
              data['providerServices']['serviceProviderCategories'] ?? [];
        }

        return RefreshIndicator(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: AddService(),
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.add_outlined, color: Colors.green),
                      title: Text('Click to add new service'),
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
                  if (services.length < 1)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: Text(
                        'You currently have no services listed',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ...services.map(
                    (service) {
                      Map _service = service['service'];
                      Map category = service['category'];
                      return Column(
                        children: [
                          Service(
                            serviceId: _service['id'],
                            name: _service['title'],
                            description: _service['description'],
                            price: double.parse(_service['price'].toString()),
                            category: category['category'],
                            inHouse: _service['inHouse'],
                            duration:
                                double.parse(_service['duration'].toString()),
                            durationUnit: _service['durationUnit'],
                          ),
                          SizedBox(
                            height: 5.0,
                          )
                        ],
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
            onRefresh: refetch);
      },
    );
  }
}
