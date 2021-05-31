import 'package:flutter/material.dart';

class AndroidButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function pressed;
  final Color backgroundColor;
  final Color color;

  const AndroidButton({
    this.label,
    this.icon,
    this.pressed,
    this.backgroundColor = Colors.lightBlue,
    this.color = Colors.white,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: TextButton(
        child: Text(label, style: TextStyle(color: color, fontSize: 20.0),),
        onPressed: pressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
      ),
    );
  }
}
