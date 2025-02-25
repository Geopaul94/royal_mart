

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';

import 'package:royalmart/presentation/screens/cartscreen/cart_screen.dart';

import 'package:royalmart/presentation/screens/productdetails/product_details.dart';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:royalmart/presentation/screens/wishlistscreen/wishlist_screen.dart';
import 'package:royalmart/presentation/widgets/CustomBottomNav.dart';
import 'package:royalmart/presentation/widgets/custom_addcart.dart';
import 'package:royalmart/presentation/widgets/custome_appbar.dart';
import 'package:royalmart/presentation/widgets/custome_likedt.dart';
import 'package:royalmart/presentation/widgets/custon_product_container.dart';
import 'package:royalmart/presentation/widgets/shimmer_loading.dart';







  
  
  
  
  
  
  
  
  
  
  
  
  
  Positioned allProductsDetails(
      CartWishlistSuccess state, List<ProductModel> products) {
    return Positioned(
      top: 81.h,
      left: 0,
      right: 0,
      bottom: 10.h,
      child: Container(
        padding: EdgeInsets.all(8.w),
        color: Colors.white,
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          itemCount: products.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index < products.length) {
              final product = products[index];
              final isIncart = state.cart.any((item) => item.id == product.id);
              final isInWishlist =
                  state.wishlist.any((item) => item.id == product.id);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ProductDetails(product: product),
                    ),
                  );
                },
                child: customeimageContainer(
                    index, product, isIncart, isInWishlist, context),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

