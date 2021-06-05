import 'dart:async';

import 'package:flutter/material.dart';
import 'package:groomzy/android/screens/provider/main.dart';

import '../../widgets/horizontal_scroll/labels.dart';
import '../../widgets/rating/rating.dart';
import '../../../common/constants/constants.dart';

class AndroidSummaryService extends StatelessWidget {
  const AndroidSummaryService({Key key}) : super(key: key);

  Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    final url = 'https://image.png';
    final image = NetworkImage(url);

    final load = image.resolve(const ImageConfiguration());

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
      print(info.image.width);
      print(info.image.height);

      if (info.image.width == 80 && info.image.height == 160) {
        completer.complete(Container(child: Text('AZAZA')));
      } else {
        completer.complete(Container(child: Image(image: image)));
      }
    });

    load.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text('Test Barber'),
                  subtitle:
                      Text('87 Business building, Smith Street, Durban, 4066'),
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
                        ProviderScreen.routeName,
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
                      child: AndroidLabels(),
                    ),
                    Divider(),
                    AndroidRating(),
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
