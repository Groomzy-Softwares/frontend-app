import 'package:flutter/material.dart';

class AndroidCenterHorizontalExpanded extends StatelessWidget {
  final Widget screenContent;

  AndroidCenterHorizontalExpanded({
    @required this.screenContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: screenContent),
      ],
    );
  }
}
