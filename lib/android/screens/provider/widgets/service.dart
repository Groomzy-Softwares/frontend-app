import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../book/main.dart';

class AndroidService extends StatelessWidget {
  const AndroidService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(BookScreen.routeName);
      },
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 290,
                      child: AutoSizeText(
                        'description of the service description description '
                            'description description description',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54),
                        minFontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Book',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(Icons.chevron_right_outlined),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text('R200')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
