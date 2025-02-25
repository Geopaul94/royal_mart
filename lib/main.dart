import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:royalmart/data/model/product_model.dart';

import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';

import 'package:royalmart/presentation/screens/cart_screen.dart';

import 'package:royalmart/presentation/screens/product_details.dart';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:royalmart/presentation/screens/wishlist_screen.dart';
import 'package:royalmart/presentation/widgets/CustomBottomNav.dart';
import 'package:royalmart/presentation/widgets/custom_addcart.dart';
import 'package:royalmart/presentation/widgets/custome_appbar.dart';
import 'package:royalmart/presentation/widgets/custome_likedt.dart';
import 'package:royalmart/presentation/widgets/shimmer_loading.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 802), // Standard mobile size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => CartWishlistBloc(),
          child: MaterialApp(debugShowCheckedModeBanner: false,
            home: Samplescreen(),
          ),
        );
      },
    );
  }
}

class Samplescreen extends StatefulWidget {
  const Samplescreen({super.key});

  @override
  State<Samplescreen> createState() => _SamplescreenState();
}

class _SamplescreenState extends State<Samplescreen> {
  int selectedIndex = 0;
  bool isSearching = false; // Toggle search bar visibility
  String searchQuery = ''; // Store search input

  void onSelected(int index) {
    setState(() {
      selectedIndex = index;
      isSearching = false; // Reset search when switching tabs
    });
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      searchQuery = ''; // Clear query when toggling
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        int wishlistCount = 0;
        int cartCount = 0;
        List<ProductModel> filteredProducts = []; // For search results
        if (state is CartWishlistSuccess) {
          wishlistCount = state.wishlist.length;
          cartCount = state.cart.length;
          // Filter products based on search query
          filteredProducts = searchQuery.isEmpty
              ? state.products
              : state.products
                  .where((product) => product.title!
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();
        }

        return Scaffold(
          appBar: CustomAppBar(
            wishlistCount: wishlistCount,
            cartCount: cartCount,
            onSearchPressed: toggleSearch,
            isSearching: isSearching,
            searchQuery: searchQuery,
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              if (state is CartWishlistLoading)
                ShimmerLoading(), // Replace with ShimmerLoading if defined
              if (state is CartWishlistSuccess) ...[
                if (selectedIndex == 0) ...[
                  if (!isSearching) ...[
                    allproductstext(),
                    allProductsDetails(state, filteredProducts),
                  ] else ...[
                    // Show search results when searching
                    filteredProducts.isNotEmpty
                        ? allProductsDetails(state, filteredProducts)
                        : Center(
                            child: Text(
                              'No products found for "$searchQuery"',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            ),
                          ),
                  ],
                ],
                if (selectedIndex == 1) WishlistScreen(),
                if (selectedIndex == 2) CartScreen(),
              ],
              if (state is CartWishlistError)
                Center(
                    child: Text(state.error,
                        style: TextStyle(color: Colors.white))),
              Positioned(
                bottom: 30.h,
                left: 70.w,
                right: 70.w,
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(62, 158, 158, 158),
                      width: 1.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(35.r)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomBottomNav(
                          icon: Icons.home,
                          isSelected: selectedIndex == 0,
                          onTap: () => onSelected(0),
                        ),
                        CustomBottomNav(
                          icon: Icons.favorite,
                          isSelected: selectedIndex == 1,
                          onTap: () => onSelected(1),
                        ),
                        CustomBottomNav(
                          icon: Icons.shopping_cart,
                          isSelected: selectedIndex == 2,
                          onTap: () => onSelected(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Positioned allproductstext() {
    return Positioned(
      top: 25.h,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 55.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(40),
                topStart: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Text(
                'All products',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              final isIncart =
                  state.cart.any((item) => item.id == product.id);
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
                  child:CustomAddcart(
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
}
