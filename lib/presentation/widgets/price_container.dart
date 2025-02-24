
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/utilities/constants/constants.dart';

Widget priceContainer(String title,
    {Color? color, double? height, double? width}) {
  return Container(height: height,width: width,decoration: BoxDecoration(
    color: const Color.fromARGB(146, 158, 158, 158),borderRadius: BorderRadius.circular(15)
  ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(  fontSize: 14.sp,  color: black)),
      ),
  
  );
}
