// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:royalmart/data/model/product_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartWishlistProvider with ChangeNotifier {
//   List<Product> _wishlist = [];
//   List<Product> _cart = [];

//   List<Product> get wishlist => _wishlist;
//   List<Product> get cart => _cart;

//   CartWishlistProvider() {
//     _loadData();
//   }

//   void addToWishlist(Product product) {
//     if (!_wishlist.any((item) => item.id == product.id)) {
//       _wishlist.add(product);
//       _saveData();
//       notifyListeners();
//     }
//   }

//   // void addToCart(Product product) {
//   //   if (!_cart.any((item) => item.id == product.id)) {
//   //     _cart.add(product);
//   //     _saveData();
//   //     notifyListeners();
//   //   }
//   // }

// // 



//   void addToCart(Product product) {
//   _cart.add(product); // No duplicate check
//   _saveData();
//   notifyListeners();
// }

//   void removeFromWishlist(Product product) {
//     _wishlist.removeWhere((item) => item.id == product.id);
//     _saveData();
//     notifyListeners();
//   }

//   void removeFromCart(Product product) {
//     _cart.removeWhere((item) => item.id == product.id);
//     _saveData();
//     notifyListeners();
//   }

//  Future<void> _saveData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final wishlistJson = jsonEncode(_wishlist.map((item) => item.toJson()).toList());
//   final cartJson = jsonEncode(_cart.map((item) => item.toJson()).toList());
//   print('Saving wishlist: $wishlistJson');
//   print('Saving cart: $cartJson');
//   await prefs.setString('wishlist', wishlistJson);
//   await prefs.setString('cart', cartJson);
// }

// Future<void> _loadData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final wishlistData = prefs.getString('wishlist');
//   final cartData = prefs.getString('cart');
//  // print('Loaded wishlist: $wishlistData');
//   print('Loaded cart: $cartData');

//   if (wishlistData != null) {
//     _wishlist = (jsonDecode(wishlistData) as List)
//         .map((item) => Product.fromJson(item))
//         .toList();
//   }
//   if (cartData != null) {
//     _cart = (jsonDecode(cartData) as List)
//         .map((item) => Product.fromJson(item))
//         .toList();
//   }
//   notifyListeners();
// }}