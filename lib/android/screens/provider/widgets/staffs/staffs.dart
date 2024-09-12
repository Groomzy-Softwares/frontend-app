import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './staff.dart';
import './add_staff.dart';
import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/queries/provider/provider_staffs.dart';

class Staffs extends StatelessWidget {
  final int providerId;

  const Staffs({this.providerId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(ProviderStaffsQuery().providerStaffs),
        variables: {'providerId': providerId},
      ),
      builder: (
        QueryResult providerStaffsResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (providerStaffsResult.hasException) {
          if (providerStaffsResult.exception.graphqlErrors.length > 0) {
            errorMessage =
                providerStaffsResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (providerStaffsResult.isLoading) {
          return AndroidLoading();
        }

        Map data = providerStaffsResult.data;
        List staffs = [];

        if (data != null && data['providerStaffs'] != null) {
          staffs = data['providerStaffs']['staffs'] ?? [];
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
                          child: AddStaff(),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.add_outlined, color: Colors.green),
                    title: Text('Click to add new staff'),
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
                if (staffs.length < 1)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: Text(
                      'You currently have no staffs.',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ...staffs.map(
                  (staff) {
                    return Column(
                      children: [
                        Staff(
                          fullName: staff['fullName'],
                          staffId: staff['id'],
                        ),
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
