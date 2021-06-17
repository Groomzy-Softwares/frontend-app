import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/rating/rating.dart';

class Rating extends StatelessWidget {
  final double ratingPercentage;
  final String ratingStatus;
  final double ratingCounts;
  final Function onRatingUpdate;

  const Rating({
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
        title: AndroidRating(
          ratingCounts: ratingCounts,
          onRatingUpdate: onRatingUpdate,
          itemSize: 24,
          icon: Icons.star_outline,
          iconColor: Colors.green,
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