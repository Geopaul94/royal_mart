
import 'package:flutter/material.dart';
import 'package:royalmart/utilities/constants/constants.dart';

Widget customMaterialButton(String title,
    {Color? color, double? height, double? width}) {
  return Container(height: height,width: width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? buttoncolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
