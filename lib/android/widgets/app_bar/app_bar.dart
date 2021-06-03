import 'package:flutter/material.dart';

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
      centerTitle: true,
      elevation: 0.0,
    );
  }
}
