import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  CustomText({
    required this.text,
    double? fontSize,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.black,
  }) : this.fontSize = fontSize ?? 16.sp; // Initialize fontSize in constructor

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: 'Normal',
      ),
    );
  }
}
