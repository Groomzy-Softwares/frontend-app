import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AndroidCategory extends StatelessWidget {
  final String imageAssetPath;
  final String category;

  const AndroidCategory({
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
      margin: EdgeInsets.only(right: 5.0),
      child: GestureDetector(
        child: GridTile(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Theme.of(context).primaryColor,
                child: Image.asset(
                  imageAssetPath,
                  height: 50.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              AutoSizeText(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0
                ),
                maxLines: 1,
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
