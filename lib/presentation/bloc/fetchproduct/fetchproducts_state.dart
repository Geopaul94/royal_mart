// import 'package:royalmart/data/model/product_model.dart';

// abstract class FetchProductsState {}

// class FetchProductsInitial extends FetchProductsState {}

// class FetchProductsLoading extends FetchProductsState {}

// class FetchProductsSuccess extends FetchProductsState {
//   final List<ProductModel> products;

//   FetchProductsSuccess({required this.products});
// }

// class FetchProductsError extends FetchProductsState {
//   final String errorMessage;

//   FetchProductsError({required this.errorMessage});
// }





import 'package:flutter/foundation.dart';
import 'package:royalmart/data/model/product.dart';


@immutable
class CartWishlistState {
  final List<Product> wishlist;
  final List<Product> cart;

  CartWishlistState({
    required this.wishlist,
    required this.cart,
  });

  factory CartWishlistState.initial() => CartWishlistState(
        wishlist: [],
        cart: [],
      );

  CartWishlistState copyWith({
    List<Product>? wishlist,
    List<Product>? cart,
  }) {
    return CartWishlistState(
      wishlist: wishlist ?? this.wishlist,
      cart: cart ?? this.cart,
    );
  }
}