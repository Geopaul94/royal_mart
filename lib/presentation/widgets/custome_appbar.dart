import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/presentation/screens/cartscreen/cart_screen.dart';
import 'package:royalmart/presentation/screens/wishlistscreen/wishlist_screen.dart';

import 'package:badges/badges.dart' as badges;
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int wishlistCount;
  final int cartCount;
  final VoidCallback onSearchPressed;
  final bool isSearching;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const CustomAppBar({
    super.key,
    required this.wishlistCount,
    required this.cartCount,
    required this.onSearchPressed,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(isSearching ? 100.h : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.search,
          color: Colors.grey,
          size: 24.sp,
        ),
        onPressed: onSearchPressed,
      ),
      backgroundColor: Colors.black,
      elevation: 1,
      title: isSearching
          ? TextField(
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                border: InputBorder.none,
              ),
              onChanged: onSearchChanged,
            )
          : null,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!isSearching)
                Text(
                  "Royal Mart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              SizedBox(width: 20.w),
              badges.Badge(
                badgeContent: Text(
                  cartCount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blue),
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.green,
                    size: 30.sp,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
              ),
              SizedBox(width: 10.w),
              badges.Badge(
                badgeContent: Text(
                  wishlistCount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.heart,
                    color: Colors.red,
                    size: 30.sp,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => WishlistScreen()),
                    );
                  },
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ],
    );
  }
}
