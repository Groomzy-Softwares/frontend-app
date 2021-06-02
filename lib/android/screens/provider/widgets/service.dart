import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AndroidService extends StatelessWidget {
  const AndroidService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  width: 280,
                  child: AutoSizeText(
                    'description of the service description description '
                        'description of the service description description '
                        'description of the service description description '
                        'description description description',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
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
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'Book',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                      Icon(Icons.chevron_right_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Text('R200')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
