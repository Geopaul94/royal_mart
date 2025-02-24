import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:royalmart/data/model/product.dart';
import 'package:royalmart/data/repository/fetch_products.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';

// class FetchProductsBloc extends Bloc<FetchProductsEvent, FetchProductsState> {
//   final ApiService apiService;

//   FetchProductsBloc({required this.apiService}) : super(FetchProductsInitial()) {
//     on<FetchProductsInitialEvent>(_fetchProducts);
//   }

//  Future<void> _fetchProducts(
//     FetchProductsInitialEvent event, Emitter<FetchProductsState> emit) async {
//   emit(FetchProductsLoading());

//   try {
//     final products = await apiService.fetchProducts();
//     emit(FetchProductsSuccess(products: products));
//   } on SocketException {
//     emit(FetchProductsError(errorMessage: 'No internet connection. Please check your network settings.'));
//   } on HttpException {
//     emit(FetchProductsError(errorMessage: 'An HTTP error occurred. Please try again later.'));
//   } on FormatException {
//     emit(FetchProductsError(errorMessage: 'An error occurred while parsing the response. Please try again later.'));
//   } catch (e) {
//     emit(FetchProductsError(errorMessage: 'An unknown error occurred. Please try again later.'));
//   }
// }
// }

// void showCustomSnackBar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.red,
//       duration: Duration(seconds: 3),
//     ),
//   );
// }














// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartWishlistBloc extends Bloc<CartWishlistEvent, CartWishlistState> {
//   CartWishlistBloc() : super(CartWishlistLoading()) {
//     on<LoadCartWishlist>(_onLoadCartWishlist);
//     on<AddToWishlist>(_onAddToWishlist);
//     on<RemoveFromWishlist>(_onRemoveFromWishlist);
//     on<AddToCart>(_onAddToCart);
//     on<RemoveFromCart>(_onRemoveFromCart);

//     // Load data when bloc is initialized
//     add(LoadCartWishlist());
//   }

//   Future<void> _onLoadCartWishlist(
//     LoadCartWishlist event,
//     Emitter<CartWishlistState> emit,
//   ) async {
//     emit(CartWishlistLoading());
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final wishlistData = prefs.getString('wishlist');
//       final cartData = prefs.getString('cart');

//       List<Product> wishlist = [];
//       List<Product> cart = [];

//       if (wishlistData != null) {
//         wishlist = (jsonDecode(wishlistData) as List)
//             .map((item) => Product.fromJson(item))
//             .toList();
//       }
//       if (cartData != null) {
//         cart = (jsonDecode(cartData) as List)
//             .map((item) => Product.fromJson(item))
//             .toList();
//       }

//       emit(CartWishlistSuccess(wishlist: wishlist, cart: cart));
//     } catch (e) {
//       emit(CartWishlistError('Failed to load data: $e'));
//     }
//   }

//   Future<void> _onAddToWishlist(
//     AddToWishlist event,
//     Emitter<CartWishlistState> emit,
//   ) async {
//     if (state is CartWishlistSuccess) {
//       final currentState = state as CartWishlistSuccess;
//       if (!currentState.wishlist.any((item) => item.id == event.product.id)) {
//         final updatedWishlist = List<Product>.from(currentState.wishlist)
//           ..add(event.product);
//         emit(CartWishlistSuccess(
//           wishlist: updatedWishlist,
//           cart: currentState.cart,
//         ));
//         await _saveData(updatedWishlist, currentState.cart);
//       }
//     }
//   }

//   Future<void> _onRemoveFromWishlist(
//     RemoveFromWishlist event,
//     Emitter<CartWishlistState> emit,
//   ) async {
//     if (state is CartWishlistSuccess) {
//       final currentState = state as CartWishlistSuccess;
//       final updatedWishlist = List<Product>.from(currentState.wishlist)
//         ..removeWhere((item) => item.id == event.product.id);
//       emit(CartWishlistSuccess(
//         wishlist: updatedWishlist,
//         cart: currentState.cart,
//       ));
//       await _saveData(updatedWishlist, currentState.cart);
//     }
//   }

//   Future<void> _onAddToCart(
//     AddToCart event,
//     Emitter<CartWishlistState> emit,
//   ) async {
//     if (state is CartWishlistSuccess) {
//       final currentState = state as CartWishlistSuccess;
//       if (!currentState.cart.any((item) => item.id == event.product.id)) {
//         final updatedCart = List<Product>.from(currentState.cart)
//           ..add(event.product);
//         emit(CartWishlistSuccess(
//           wishlist: currentState.wishlist,
//           cart: updatedCart,
//         ));
//         await _saveData(currentState.wishlist, updatedCart);
//       }
//     }
//   }

//   Future<void> _onRemoveFromCart(
//     RemoveFromCart event,
//     Emitter<CartWishlistState> emit,
//   ) async {
//     if (state is CartWishlistSuccess) {
//       final currentState = state as CartWishlistSuccess;
//       final updatedCart = List<Product>.from(currentState.cart)
//         ..removeWhere((item) => item.id == event.product.id);
//       emit(CartWishlistSuccess(
//         wishlist: currentState.wishlist,
//         cart: updatedCart,
//       ));
//       await _saveData(currentState.wishlist, updatedCart);
//     }
//   }

//   Future<void> _saveData(List<Product> wishlist, List<Product> cart) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(
//         'wishlist', jsonEncode(wishlist.map((item) => item.toJson()).toList()));
//     await prefs.setString(
//         'cart', jsonEncode(cart.map((item) => item.toJson()).toList()));
//   }
// }














import 'package:flutter/foundation.dart';
import 'package:royalmart/data/model/product_model.dart';

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartWishlistBloc extends Bloc<CartWishlistEvent, CartWishlistState> {
  CartWishlistBloc() : super(CartWishlistLoading()) {
    on<LoadCartWishlist>(_onLoadCartWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);

    add(LoadCartWishlist());
  }

  Future<void> _onLoadCartWishlist(
    LoadCartWishlist event,
    Emitter<CartWishlistState> emit,
  ) async {
    emit(CartWishlistLoading());
    try {
      final products = await ApiService().fetchProducts();
      print('Products loaded: ${products.length}');
      
      final prefs = await SharedPreferences.getInstance();
      final wishlistData = prefs.getString('wishlist');
      final cartData = prefs.getString('cart');

      List<ProductModel> wishlist = [];
      List<ProductModel> cart = [];

      if (wishlistData != null) {
        try {
          wishlist = (jsonDecode(wishlistData) as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
          print('Wishlist loaded: ${wishlist.length}');
        } catch (e) {
          print('Wishlist parsing error: $e');
        }
      }
      if (cartData != null) {
        try {
          cart = (jsonDecode(cartData) as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
          print('Cart loaded: ${cart.length}');
        } catch (e) {
          print('Cart parsing error: $e');
        }
      }

      emit(CartWishlistSuccess(
        products: products,
        wishlist: wishlist,
        cart: cart,
      ));
    } catch (e) {
      print('Load error: $e');
      emit(CartWishlistError('Failed to load data: $e'));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlist event,
    Emitter<CartWishlistState> emit,
  ) async {
    if (state is CartWishlistSuccess) {
      final currentState = state as CartWishlistSuccess;
      if (!currentState.wishlist.any((item) => item.id == event.product.id)) {
        final updatedWishlist = List<ProductModel>.from(currentState.wishlist)
          ..add(event.product);
        emit(CartWishlistSuccess(
          products: currentState.products,
          wishlist: updatedWishlist,
          cart: currentState.cart,
        ));
        await _saveData(updatedWishlist, currentState.cart);
      }
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<CartWishlistState> emit,
  ) async {
    if (state is CartWishlistSuccess) {
      final currentState = state as CartWishlistSuccess;
      final updatedWishlist = List<ProductModel>.from(currentState.wishlist)
        ..removeWhere((item) => item.id == event.product.id);
      emit(CartWishlistSuccess(
        products: currentState.products,
        wishlist: updatedWishlist,
        cart: currentState.cart,
      ));
      await _saveData(updatedWishlist, currentState.cart);
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartWishlistState> emit,
  ) async {
    if (state is CartWishlistSuccess) {
      final currentState = state as CartWishlistSuccess;
      if (!currentState.cart.any((item) => item.id == event.product.id)) {
        final updatedCart = List<ProductModel>.from(currentState.cart)
          ..add(event.product);
        emit(CartWishlistSuccess(
          products: currentState.products,
          wishlist: currentState.wishlist,
          cart: updatedCart,
        ));
        await _saveData(currentState.wishlist, updatedCart);
      }
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartWishlistState> emit,
  ) async {
    if (state is CartWishlistSuccess) {
      final currentState = state as CartWishlistSuccess;
      final updatedCart = List<ProductModel>.from(currentState.cart)
        ..removeWhere((item) => item.id == event.product.id);
      emit(CartWishlistSuccess(
        products: currentState.products,
        wishlist: currentState.wishlist,
        cart: updatedCart,
      ));
      await _saveData(currentState.wishlist, updatedCart);
    }
  }

  Future<void> _saveData(List<ProductModel> wishlist, List<ProductModel> cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'wishlist', jsonEncode(wishlist.map((item) => item.toJson()).toList()));
    await prefs.setString(
        'cart', jsonEncode(cart.map((item) => item.toJson()).toList()));
  }
}