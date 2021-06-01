import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AndroidRating extends StatelessWidget {
  const AndroidRating({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.smile,
          color: Colors.green,
        ),
        title: RatingBar.builder(
          initialRating: 2.5,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 24,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.green,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        subtitle: Text('80% Excellent service'),
        trailing: Column(
          children: [
            Text('50 ratings'),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
