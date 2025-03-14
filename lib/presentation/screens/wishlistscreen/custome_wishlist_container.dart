

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/widgets/cusotme_product_rating.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:royalmart/utilities/constants/constants.dart';
import 'package:royalmart/utilities/functions/product_name.dart';
import 'package:royalmart/utilities/functions/sanckBar.dart';

import '../../bloc/fetchproduct/fetchproducts_state.dart';








class CustomWishlistContainer extends StatelessWidget {
  final ProductModel product;
  const CustomWishlistContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: .5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  product.image ?? '',
                  width: double.infinity,
                  height: 175,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error, size: 24.sp),
                ),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    w5,
                    Text(
                      truncateProductTitle(product.title.toString()),
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    w5,
                    ProductRating(
                      rating: product.rating.rate,
                      count: product.rating.count,
                    ),
                  ],
                ),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: '\$ ${product.price.toString()}',
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<CartWishlistBloc>()
                                .add(AddToCart(product));

                            showCustomSnackBar(context, 'Product Added to cart',
                                backgroundColor: green);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            child: CustomText(
                              text: 'Add to cart',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -5,
            top: -10,
            child: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red, size: 26.sp),
              onPressed: () {
                context
                    .read<CartWishlistBloc>()
                    .add(RemoveFromWishlist(product));

                showCustomSnackBar(context, 'Product removed from Wishlist');
              },
            ),
          ),
        ],
      ),
    );
  }
}
