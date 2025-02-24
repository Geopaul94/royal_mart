import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:royalmart/utilities/constants/constants.dart';

import '../bloc/fetchproduct/fetchproducts_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        if (state is CartWishlistLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CartWishlistSuccess) {
          // Calculate total price of items in cart
          final double totalPrice = state.cart.fold(
            0.0,
            (sum, product) => sum + product.price,
          );

          return Scaffold(
            backgroundColor: black,
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
                "My Cart",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    final product = state.cart[index];
                    return ListTile(
                      leading: Image.network(
                        product.image ?? '',
                        width: 50.w,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error, size: 24.sp),
                      ),
                      title: Text(
                        product.title ?? 'Unknown',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      subtitle: Text(
                        '\$${product.price}',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove, color: Colors.red, size: 20.sp),
                        onPressed: () {
                          context
                              .read<CartWishlistBloc>()
                              .add(RemoveFromCart(product));
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 10.w,
                  left: 10.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: -5,
                          blurRadius: 5,
                          offset: const Offset(0, -6),
                        ),
                      ],
                      border: Border(
                        top: BorderSide(
                          color: Colors.orange,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                      child: CustomText(
                        text: ' \$${totalPrice.toStringAsFixed(2)}',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 25.w,
                  bottom: 20.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: black,
                        width: 1.w,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: CustomText(
                        text: 'Place Order',
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CartWishlistError) {
          return Scaffold(
            appBar: AppBar(title: Text('Cart')),
            body: Center(child: Text(state.error)),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Cart')),
          body: Center(child: Text('Unexpected state')),
        );
      },
    );
  }
}