import 'package:flutter/material.dart';

class AndroidTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final double borderRadius;
  final Color labelColor;
  final Color borderColor;
  final Color suffixIconColor;
  final Color prefixIconColor;
  final Color cursorColor;

  const AndroidTextField({
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 0,
    this.borderColor = Colors.grey,
    this.labelColor = Colors.grey,
    this.suffixIconColor = Colors.grey,
    this.prefixIconColor = Colors.grey,
    this.cursorColor =  Colors.grey,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        cursorColor: cursorColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          labelStyle: TextStyle(
            color: labelColor,
          ),
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: prefixIconColor,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Icon(
                  suffixIcon,
                  color: suffixIconColor,
                )
              : null,
        ),
      ),
    );
  }
}
