


import 'package:flutter/foundation.dart';
import 'package:royalmart/data/model/product_model.dart';

@immutable
abstract class CartWishlistEvent {}

class LoadCartWishlist extends CartWishlistEvent {}

class AddToWishlist extends CartWishlistEvent {
  final ProductModel product;
  AddToWishlist(this.product);
}

class RemoveFromWishlist extends CartWishlistEvent {
  final ProductModel product;
  RemoveFromWishlist(this.product);
}

class AddToCart extends CartWishlistEvent {
  final ProductModel product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartWishlistEvent {
  final ProductModel product;
  RemoveFromCart(this.product);
}