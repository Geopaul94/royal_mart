import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Add horizontal padding
        child: Text(
          message,
          style: TextStyle(color: Colors.white), // Customize text color
        ),
      ),
      backgroundColor: backgroundColor, 
      duration: Duration(seconds: 1), 
      behavior: SnackBarBehavior
          .floating, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
    ),
  );
}
