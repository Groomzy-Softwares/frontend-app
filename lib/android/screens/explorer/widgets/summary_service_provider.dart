import 'package:flutter/material.dart';
import 'package:groomzy/common/utils/utils.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../provider_trading/main.dart';
import './rating.dart';

import '../../../widgets/horizontal_scroll/labels.dart';
import '../../../../common/constants/constants.dart';

class AndroidSummaryService extends StatelessWidget {
  final String address;
  final String fullName;
  final double latitude;
  final double longitude;
  final String category;
  final List categories;
  final List ratings;

  AndroidSummaryService({
    this.address,
    this.fullName,
    this.latitude,
    this.longitude,
    this.category,
    this.categories,
    this.ratings,
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
                      if (latitude != null && longitude != null) {
                        if (await MapLauncher.isMapAvailable(MapType.google)) {
                          await MapLauncher.showMarker(
                            mapType: MapType.google,
                            coords: Coords(latitude, longitude),
                            title: address,
                          );
                        }
                      }
                    },
                    child: Icon(Icons.location_on_outlined),
                  ),
                  title: Text(fullName ?? 'No name or business name'),
                  subtitle: Text(address ?? 'No address'),
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
