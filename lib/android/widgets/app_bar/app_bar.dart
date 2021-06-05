import 'package:flutter/material.dart';

import '../../screens/home/main.dart';

class AndroidAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  AndroidAppBar({
    @required this.title,
    Key key,
  })  : preferredSize = Size.fromHeight(55.0),
        super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            child: Icon(Icons.home_outlined, size: 30,),
          ),
        )
      ],
      elevation: 0.0,
    );
  }
}
