



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



class CustomCartContainer extends StatelessWidget {
  final ProductModel product;
  const CustomCartContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 5),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the top
            children: [
              // Image Column
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image ?? '',
                    width: 80.w,
                    height: 80.h,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, size: 24.sp),
                  ),
                  h5,
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
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Qty :',
                              color: Colors.white,
                            ),
                            CustomText(
                              text: '1',
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10), // Space between image and title
              // Title and Rating Column
              Expanded(
                // Use Expanded to take available space
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align to the top
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateProductTitle(product.title.toString()),
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                    ProductRating(
                      rating: product.rating.rate,
                      count: product.rating.count,
                    ),
                    h20,
                    CustomText(
                      text:
                          '\$  ${product.price.toString()}', // Correctly format the string
                      color: Colors.green,
                    ),
                    h10,
                    CustomText(
                      text: "Delivered by Feb 26 Wed. ",
                      color: grey,
                      fontSize: 14.sp,
                    )
                  ],
                ),
              ),
              // Centered IconButton
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the button vertically
                children: [
                  h30,
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.remove, color: Colors.red, size: 24.sp),
                      onPressed: () {
                        context
                            .read<CartWishlistBloc>()
                            .add(RemoveFromCart(product));

                        showCustomSnackBar(
                            context, 'Product removed from cart');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
