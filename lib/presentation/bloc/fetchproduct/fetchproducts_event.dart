// abstract class FetchProductsEvent {}

// class FetchProductsInitialEvent extends FetchProductsEvent {}



import 'package:flutter/foundation.dart';
import 'package:royalmart/data/model/product.dart';

@immutable
abstract class CartWishlistEvent {}

class LoadCartWishlist extends CartWishlistEvent {}

class AddToWishlist extends CartWishlistEvent {
  final Product product;
  AddToWishlist(this.product);
}

class RemoveFromWishlist extends CartWishlistEvent {
  final Product product;
  RemoveFromWishlist(this.product);
}

class AddToCart extends CartWishlistEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartWishlistEvent {
  final Product product;
  RemoveFromCart(this.product);
}