import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/utilities/constants/constants.dart';

class ProductRating extends StatelessWidget {
  final double rating; // The rating value (e.g., 4.2 out of 5)
  final int totalStars; // The total number of stars, usually 5
  final int count;
  ProductRating(
      {required this.rating, this.totalStars = 5, required this.count});

  // Custom function to generate star icons based on rating
  List<Widget> buildStarRating() {
    List<Widget> stars = [];
    int filledStars = rating.floor(); // Number of filled stars
    bool hasHalfStar =
        (rating - filledStars) >= 0.5; // Check if there is a half star

    // Add filled stars
    for (int i = 0; i < filledStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow, size: 16.sp));
    }

    // Add half star if applicable
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow, size: 16.sp));
    }

    // Add empty stars to complete the total stars
    while (stars.length < totalStars) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow, size: 16.sp));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: buildStarRating(),
        ),
        SizedBox(width: 4.w),
        Text(
          '$rating', // Display the rating number
          style: TextStyle(fontSize: 12.sp, color: white),
        ),
        w10,
        Text(
          '($count)', // Display the count with parentheses
          style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey), // Change color to black for visibility
        ),
      ],
    );
  }
}
