import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String imageAssetPath;
  final String category;

  const Category({
    this.imageAssetPath,
    this.category,
    Key key,
  }) : super(key: key);

  void navigateToRespectiveScreen({String category}) {
    if ('Provider' == 'Provider') {
      print('wrt Provider');
    } else if ('Client' == 'Client') {
      print('wrt client');
    } else {
      print('wrt guest');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 20),
      child: GestureDetector(
        child: GridTile(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: Image.asset(
                  imageAssetPath,
                  height: 60.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0
                ),
              )
            ],
          ),
        ),
        onTap: () {
          navigateToRespectiveScreen(
            category: category,
          );
        },
      ),
    );
  }
}
