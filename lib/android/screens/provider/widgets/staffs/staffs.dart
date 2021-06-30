import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './staff.dart';
import './add_staff.dart';
import '../../../../widgets/loading/loading.dart';

import '../../../../../api/graphql/queries/staff/staffs.dart';

class Staffs extends StatelessWidget {
  const Staffs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(StaffsQuery().staffs)),
      builder: (
        QueryResult staffsResult, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        String errorMessage;
        if (staffsResult.hasException) {
          if (staffsResult.exception.graphqlErrors.length > 0) {
            errorMessage = staffsResult.exception.graphqlErrors[0].message;
          } else {
            errorMessage = 'Oops! seems like there is something wrong, '
                'please alert us at support@groomzy.co.za with this issue.';
          }
        }

        if (staffsResult.isLoading) {
          return AndroidLoading();
        }

        Map data = staffsResult.data;
        List staffs = [];

        if (data != null && data['staffs'] != null) {
          staffs = data['staffs'];
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
                          Divider(),
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
