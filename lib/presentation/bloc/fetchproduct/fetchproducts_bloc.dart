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





import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartWishlistBloc extends Bloc<CartWishlistEvent, CartWishlistState> {
  CartWishlistBloc() : super(CartWishlistState.initial()) {
    on<LoadCartWishlist>(_onLoadCartWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);

    // Load data when bloc is initialized
    add(LoadCartWishlist());
  }

  Future<void> _onLoadCartWishlist(
    LoadCartWishlist event,
    Emitter<CartWishlistState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistData = prefs.getString('wishlist');
    final cartData = prefs.getString('cart');

    List<Product> wishlist = [];
    List<Product> cart = [];

    if (wishlistData != null) {
      wishlist = (jsonDecode(wishlistData) as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }
    if (cartData != null) {
      cart = (jsonDecode(cartData) as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }

    emit(state.copyWith(wishlist: wishlist, cart: cart));
  }

  Future<void> _onAddToWishlist(
    AddToWishlist event,
    Emitter<CartWishlistState> emit,
  ) async {
    if (!state.wishlist.any((item) => item.id == event.product.id)) {
      final updatedWishlist = List<Product>.from(state.wishlist)
        ..add(event.product);
      emit(state.copyWith(wishlist: updatedWishlist));
      await _saveData(updatedWishlist, state.cart);
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<CartWishlistState> emit,
  ) async {
    final updatedWishlist = List<Product>.from(state.wishlist)
      ..removeWhere((item) => item.id == event.product.id);
    emit(state.copyWith(wishlist: updatedWishlist));
    await _saveData(updatedWishlist, state.cart);
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartWishlistState> emit,
  ) async {
    if (!state.cart.any((item) => item.id == event.product.id)) {
      final updatedCart = List<Product>.from(state.cart)..add(event.product);
      emit(state.copyWith(cart: updatedCart));
      await _saveData(state.wishlist, updatedCart);
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartWishlistState> emit,
  ) async {
    final updatedCart = List<Product>.from(state.cart)
      ..removeWhere((item) => item.id == event.product.id);
    emit(state.copyWith(cart: updatedCart));
    await _saveData(state.wishlist, updatedCart);
  }

  Future<void> _saveData(List<Product> wishlist, List<Product> cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'wishlist', jsonEncode(wishlist.map((item) => item.toJson()).toList()));
    await prefs.setString(
        'cart', jsonEncode(cart.map((item) => item.toJson()).toList()));
  }
}