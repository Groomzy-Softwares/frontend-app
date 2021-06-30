import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import './rating.dart';
import '../../provider_trading/main.dart';
import '../../../widgets/horizontal_scroll/labels.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/utils/utils.dart';

class AndroidSummaryService extends StatelessWidget {
  final int id;
  final Map address;
  final String name;
  final String category;
  final List categories;
  final List services;
  final List ratings;
  final List staffs;
  final List dayTimes;
  final int minimumDuration;

  AndroidSummaryService({
    this.id,
    this.address,
    this.name,
    this.category,
    this.categories,
    this.services,
    this.ratings,
    this.staffs,
    this.dayTimes,
    this.minimumDuration,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map providerRating = CommonUtils().providerRating(ratings);
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      double latitude = address["latitude"];
                      double longitude = address["longitude"];

                      if (latitude != null && longitude != null) {
                        // TODO This should be in the common utils expanding to other map types.
                        if (await MapLauncher.isMapAvailable(MapType.google)) {
                          await MapLauncher.showMarker(
                            mapType: MapType.google,
                            coords: Coords(latitude, longitude),
                            title: address['address'],
                          );
                        }
                      }
                    },
                    child: Icon(Icons.location_on_outlined),
                  ),
                  title: Text(name ?? 'No name or business name'),
                  subtitle: Text(address['address'] ?? 'No address'),
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  child: GestureDetector(
                    child: Image.asset(
                      PLACEHOLDER_IMAGE,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProviderTradingScreen.routeName,
                        arguments: {
                          'providerId': id,
                          'services': services,
                          'staffs': staffs,
                          'dayTimes': dayTimes,
                          'minimumDuration': minimumDuration,
                        }
                      );
                    },
                  ),
                  // child: FutureBuilder<Widget>(
                  //   future: getImage(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return snapshot.data;
                  //     } else {
                  //       return Text('LOADING...');
                  //     }
                  //   },
                  // ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: AndroidLabels(
                        categories: categories,
                      ),
                    ),
                    Divider(),
                    Rating(
                      ratingCounts: providerRating['ratingCounts'] ?? 0,
                      ratingPercentage: providerRating['ratingPercentage'] ?? 0,
                      ratingStatus: providerRating['ratingStatus'] ?? '',
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
