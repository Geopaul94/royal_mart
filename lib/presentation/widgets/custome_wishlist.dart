import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:royalmart/utilities/constants/constants.dart';


import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.pink,
        dotSecondaryColor: Colors.white,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.grey.withOpacity(0.5),
          size: 30,
        );
      },
      onTap: (isLiked) async {
        // Create a Snackbar with custom styling
        final snackBar = SnackBar(
          content: Text(
            isLiked
                ? 'Your product has been added to the wishlist'
                : 'This product has been removed from the wishlist',
            style: const TextStyle(color: Colors.white), // White text
          ),
          backgroundColor: isLiked ? Colors.green : Colors.red, // Green for added, red for removed
          behavior: SnackBarBehavior.floating, // Floating Snackbar
          margin: const EdgeInsets.fromLTRB(  10 ,0 ,10 , 30), // Margin to avoid touching edges
          duration: const Duration(seconds: 2),
        );

        // Show the Snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Return the new like status
        return !isLiked; // Toggle the like status
      },
    );
  }
}
