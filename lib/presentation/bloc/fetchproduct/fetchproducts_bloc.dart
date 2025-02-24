import 'package:royalmart/data/repository/fetch_products.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';
import 'package:royalmart/data/model/product_model.dart';
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

  Future<void> _saveData(
      List<ProductModel> wishlist, List<ProductModel> cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'wishlist', jsonEncode(wishlist.map((item) => item.toJson()).toList()));
    await prefs.setString(
        'cart', jsonEncode(cart.map((item) => item.toJson()).toList()));
  }
}
