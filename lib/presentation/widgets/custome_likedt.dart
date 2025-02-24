import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';

class CustomLikeButton extends StatelessWidget {
  final bool isLiked;
  final ProductModel product;

  const CustomLikeButton({
    super.key,
    required this.isLiked,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      // Add this critical line to sync with parent state
      isLiked: isLiked,
      circleColor: const CircleColor(
        start: Color(0xff00ddff),
        end: Color(0xff0099cc),
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.pink,
        dotSecondaryColor: Colors.white,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : const Color.fromARGB(193, 201, 18, 18),
          size: 30,
        );
      },
      onTap: (bool currentIsLiked) async {
        final bloc = context.read<CartWishlistBloc>();

        // Dispatch appropriate event based on CURRENT STATE (not optimistic future state)
        if (isLiked) {
          bloc.add(RemoveFromWishlist(product));
        } else {
          bloc.add(AddToWishlist(product));
        }

        // Show snackbar
        final snackBar = SnackBar(
          content: Text(
            isLiked
                ? 'Product removed from wishlist'
                : 'Product added to wishlist',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: isLiked ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          duration: const Duration(seconds: 2),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Return the NEW STATE we expect from the bloc (optimistic update)
        return !isLiked;
      },
    );
  }
}
