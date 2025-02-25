import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:royalmart/presentation/widgets/custome_appbar.dart';
import 'package:royalmart/utilities/constants/constants.dart';
import 'package:royalmart/utilities/functions/sanckBar.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Product Details ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image.toString(),
                    height: 500.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Center(
                          child: Icon(Icons.error, color: Colors.red));
                    },
                  ),
                  SizedBox(height: 16),
                  CustomText(
                    text: product.title.toString(),
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 16),
                  CustomText(
                    text: product.description.toString(),
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  SizedBox(height: 16),
                  CustomText(
                    text: "\$ ${product.price}",
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 8),
                  buildStarRating(product.rating.rate),
                  SizedBox(height: 8),
                  CustomText(
                    text: "${product.rating.count} reviews",
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  h150
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              child: Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 63, 52, 52),
                    width: 1,
                  ),
                  color: white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<CartWishlistBloc>()
                        .add(AddToWishlist(product));

                    showCustomSnackBar(context, 'Product Added to wishlist',
                        backgroundColor: green);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      children: [
                        w50,
                        CustomText(
                          text: 'Add to wishlist',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 8,
                right: 5,
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 63, 52, 52),
                      width: 1,
                    ),
                    color: const Color.fromARGB(255, 255, 152, 0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.read<CartWishlistBloc>().add(AddToCart(product));

                      showCustomSnackBar(context, 'Product Added to cart',
                          backgroundColor: green);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6),
                      child: Center(
                        child: CustomText(
                          text: 'Add to cart',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}

Widget buildStarRating(double rating) {
  int fullStars = rating.floor();
  bool hasHalfStar = rating - fullStars >= 0.5;
  List<Widget> stars = [];

  for (int i = 0; i < 5; i++) {
    if (i < fullStars) {
      stars.add(Icon(Icons.star, color: Colors.yellow));
    } else if (i == fullStars && hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow));
    } else {
      stars.add(Icon(Icons.star_border, color: Colors.yellow));
    }
  }

  return Row(
    children: stars,
  );
}
