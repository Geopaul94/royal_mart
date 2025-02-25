 
 
 
 
 
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:royalmart/presentation/widgets/shimmer_loading.dart';




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 Container customeimageContainer(int index, ProductModel product,
      bool isIncart, bool isInWishlist, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: Colors.white,
      ),
      height: index % 2 == 0 ? 360.h : 400.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    product.image ?? '',
                    height: index % 2 == 0 ? 230.h : 280.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, size: 50.sp),
                  ),
                ),
                Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: CustomLikeButton(
                      isLiked: isInWishlist,
                      product: product,
                    )),
                Positioned(
                    bottom: 8.h,
                    right: 8.w,
                    child: CustomAddcart(
                      isIncart: isIncart,
                      product: product,
                    )),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              product.title!.length > 20
                  ? '${product.title?.substring(0, 20)}...'
                  : product.title ?? 'Unknown',
              style: TextStyle(
                  color: const Color.fromARGB(182, 0, 0, 0), fontSize: 14.sp),
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              product.category ?? 'Uncategorized',
              style: TextStyle(
                color: const Color.fromARGB(182, 0, 0, 0),
                fontSize: 12.sp,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16.sp),
                Text(
                  '${product.rating.rate} (${product.rating.count})',
                  style: TextStyle(fontSize: 12.sp),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
