import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';
import 'package:royalmart/presentation/screens/homescreen/all_product_details.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
}
