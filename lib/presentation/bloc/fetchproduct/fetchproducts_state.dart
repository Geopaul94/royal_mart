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





// abstract class FetchProductsEvent {}

// class FetchProductsInitialEvent extends FetchProductsEvent {}



// import 'package:flutter/foundation.dart';
// import 'package:royalmart/data/model/product.dart';

// @immutable
// abstract class CartWishlistState {}

// class CartWishlistLoading extends CartWishlistState {}

// class CartWishlistSuccess extends CartWishlistState {
//   final List<Product> wishlist;
//   final List<Product> cart;

//   CartWishlistSuccess({
//     required this.wishlist,
//     required this.cart,
//   });
// }

// class CartWishlistError extends CartWishlistState {
//   final String error;

//   CartWishlistError(this.error);
// }
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