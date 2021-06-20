import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/rating/rating.dart';

class Rating extends StatelessWidget {
  final IconData ratingIcon;
  final Color ratingColor;
  final double ratingPercentage;
  final String ratingStatus;
  final double ratingCounts;
  final Function onRatingUpdate;

  const Rating({
    this.ratingIcon,
    this.ratingColor,
    this.ratingCounts = 0,
    this.ratingPercentage = 0,
    this.ratingStatus = 'not rated',
    this.onRatingUpdate,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: ratingCounts == 0 ? null : Icon(
          ratingIcon,
          color: ratingColor,
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