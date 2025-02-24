import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';

class CustomAddcart extends StatelessWidget {
  final bool isIncart;
  final ProductModel product;

  const CustomAddcart({
    super.key,
    required this.isIncart,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      isLiked: isIncart,
      circleColor: const CircleColor(
        start: Color(0xff00ddff),
        end: Color(0xff0099cc),
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.green,
        dotSecondaryColor: Colors.white,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.shopping_cart : Icons.add_shopping_cart,
          color: isLiked ? Colors.green : const Color.fromARGB(192, 22, 180, 22),
          size: 30,
        );
      },
      onTap: (bool currentIsLiked) async {
        final bloc = context.read<CartWishlistBloc>();

        // Use the actual current state from widget property
        if (isIncart) {
          bloc.add(RemoveFromCart(product));
        } else {
          bloc.add(AddToCart(product));
        }

        final snackBar = SnackBar(
          content: Text(
            isIncart ? 'Product removed from Cart' : 'Product added to Cart',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: isIncart ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          duration: const Duration(seconds: 2),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Return the expected new state for optimistic update
        return !isIncart;
      },
    );
  }
}
