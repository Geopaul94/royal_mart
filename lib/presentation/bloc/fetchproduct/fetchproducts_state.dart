import 'package:flutter/foundation.dart';
import 'package:royalmart/data/model/product_model.dart';

@immutable
abstract class CartWishlistState {}

class CartWishlistLoading extends CartWishlistState {}

class CartWishlistSuccess extends CartWishlistState {
  final List<ProductModel> products;
  final List<ProductModel> wishlist;
  final List<ProductModel> cart;

  CartWishlistSuccess({
    required this.products,
    required this.wishlist,
    required this.cart,
  });
}

class CartWishlistError extends CartWishlistState {
  final String error;
  CartWishlistError(this.error);
}
