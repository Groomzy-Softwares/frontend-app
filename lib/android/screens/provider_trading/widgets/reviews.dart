import 'package:flutter/material.dart';

import '../../../widgets/rating/rating.dart';

import '../../../../common/utils/utils.dart';

class Reviews extends StatelessWidget {
  const Reviews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[1, 2, 3, 4, 5, 3, 2, 4, 1, 5]
            .map(
              (rating) {
                Map ratingReview = CommonUtils().ratingReview(rating);
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black12,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Text(
                              'S',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: AndroidRating(
                        ratingCounts: rating.toDouble(),
                        icon: Icons.star_outline,
                        iconColor: ratingReview['color'],
                      ),
                      subtitle: Text(
                        'Comment here.',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(
                        ratingReview['icon'],
                        color: ratingReview['color'],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            )
            .toList(),
      ],
    );
  }
}
