import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AndroidCategory extends StatelessWidget {
  final ValueNotifier<String> selectedCategory;
  final String imageAssetPath;
  final String category;

  const AndroidCategory({
    this.selectedCategory,
    this.imageAssetPath,
    this.category,
    Key key,
  }) : super(key: key);

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
                backgroundColor: selectedCategory.value == category
                    ? Colors.green
                    : Theme.of(context).primaryColor,
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
                  fontSize: selectedCategory.value == category ? 20.0 : 16.0,
                  fontWeight: selectedCategory.value == category
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
                maxLines: 1,
              )
            ],
          ),
        ),
        onTap: () {
          if (selectedCategory.value == category) {
            selectedCategory.value = null;
          } else {
            selectedCategory.value = category;
          }
        },
      ),
    );
  }
}
