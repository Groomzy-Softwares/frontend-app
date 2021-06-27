import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './service.dart';
import './add_service.dart';

import '../../../widgets/loading/loading.dart';

import '../../../../api/graphql/queries/service/services.dart';

class Services extends StatelessWidget {
  const Services({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(ServicesQuery().services)),
      builder: (
        QueryResult servicesResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (servicesResult.hasException) {
          if (servicesResult.exception.graphqlErrors.length > 0) {
            errorMessage = servicesResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (servicesResult.isLoading) {
          return AndroidLoading();
        }

        Map data = servicesResult.data;
        List services = [];

        if (data != null && data['services'] != null) {
          services = data['services'];
        }

        return RefreshIndicator(child: SingleChildScrollView(
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
                      top: MediaQuery.of(context).size.height * 0.15),
                  child: Text(
                    'You currently have no services listed',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ...services.map(
                    (service) {
                  return Column(
                    children: [
                      Service(
                        serviceId: service['id'],
                        name: service['title'],
                        description: service['description'],
                        price: double.parse(service['price'].toString()),
                        category: service['serviceProviderCategories'][0]
                        ['category']['category'],
                        inHouse: service['inHouse'],
                        duration: double.parse(service['duration'].toString()),
                        durationUnit: service['durationUnit'],
                      ),
                      Divider(),
                    ],
                  );
                },
              ).toList(),
            ],
          ),
        ), onRefresh: refetch);
      },
    );
  }
}
