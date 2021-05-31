import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/horizontal_scroll/labels.dart';
import '../../../common/constants/constants.dart';

class AndroidService extends StatelessWidget {
  const AndroidService({Key key}) : super(key: key);

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
                  child: Image.asset(
                    PLACEHOLDER_IMAGE,
                    fit: BoxFit.cover,
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
                      child: Labels(),
                    ),
                    Divider(),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.smile,
                          color: Colors.green,
                        ),
                        title: RatingBar.builder(
                          initialRating: 0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        subtitle: Text('80% Excellent service'),
                        trailing: Column(
                          children: [
                          Text('50 ratings'),
                            SizedBox(height: 15.0,),
                            Text('Active'),
                          ],
                        ),
                      ),
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
