import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AndroidRating extends StatelessWidget {
  final double ratingCounts;
  final double itemSize;
  final IconData icon;
  final Color iconColor;
  final Function onRatingUpdate;

  const AndroidRating({
    this.ratingCounts = 0,
    this.itemSize,
    this.icon,
    this.iconColor,
    this.onRatingUpdate,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: ratingCounts,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: itemSize,
      itemBuilder: (context, _) => Icon(
        icon,
        color: iconColor,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
