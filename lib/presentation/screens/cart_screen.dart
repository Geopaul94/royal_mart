import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';

import '../bloc/fetchproduct/fetchproducts_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        if (state is CartWishlistLoading) {
          return Scaffold(
            appBar: AppBar(title: Text('Cart')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CartWishlistSuccess) {
          return Scaffold(
            appBar: AppBar(title: Text('Cart')),
            body: ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final product = state.cart[index];
                return ListTile(
                  leading: Image.network(
                    product.image ?? '',
                    width: 50,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  ),
                  title: Text(product.title ?? 'Unknown'),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      context.read<CartWishlistBloc>().add(RemoveFromCart(product));
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is CartWishlistError) {
          return Scaffold(
            appBar: AppBar(title: Text('Cart')),
            body: Center(child: Text(state.error)),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Cart')),
          body: Center(child: Text('Unexpected state')),
        );
      },
    );
  }
}