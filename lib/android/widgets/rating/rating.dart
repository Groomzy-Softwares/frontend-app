import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AndroidRating extends StatelessWidget {
  final double ratingPercentage;
  final String ratingStatus;
  final int ratingCounts;
  final Function onRatingUpdate;

  const AndroidRating({
    this.ratingCounts = 0,
    this.ratingPercentage = 0,
    this.ratingStatus = 'no rated',
    this.onRatingUpdate,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: Colors.green,
          ),
          onRatingUpdate: onRatingUpdate,
        ),
        subtitle: Text('$ratingPercentage% $ratingStatus service'),
        trailing: Column(
          children: [
            Text('$ratingCounts ratings'),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
