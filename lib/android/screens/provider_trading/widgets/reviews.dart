import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reviews extends StatelessWidget {
  const Reviews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[1, 2, 3, 4, 5, 3, 2, 4, 1, 5]
            .map(
              (rating) => Column(
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
                    title: RatingBar.builder(
                      initialRating: rating.toDouble(),
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      onRatingUpdate: null,
                    ),
                    subtitle: Text(
                      'Comment here.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      rating >= 3.75
                          ? FontAwesomeIcons.grinStars
                          : rating >= 2.5
                              ? FontAwesomeIcons.smile
                              : FontAwesomeIcons.frown,
                      color: rating >= 3.75
                          ? Colors.green
                          : rating >= 2.5
                              ? Colors.amber
                              : Colors.red,
                    ),
                  ),
                  Divider(),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
