import 'package:flutter/material.dart';

class AndroidTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final double borderRadius;

  const AndroidTextField({
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 0,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:  BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Icon(
            suffixIcon,
          )
              : null,
        ),
      ),
    );
  }
}
