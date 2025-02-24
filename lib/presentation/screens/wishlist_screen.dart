import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';

import '../bloc/fetchproduct/fetchproducts_state.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        if (state is CartWishlistLoading) {
          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CartWishlistSuccess) {
          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: ListView.builder(
              itemCount: state.wishlist.length,
              itemBuilder: (context, index) {
                final product = state.wishlist[index];
                return ListTile(
                  leading: Image.network(
                    product.image ?? '',
                    width: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                  ),
                  title: Text(product.title ?? 'Unknown'),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      context
                          .read<CartWishlistBloc>()
                          .add(RemoveFromWishlist(product));
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is CartWishlistError) {
          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: Center(child: Text(state.error)),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Wishlist')),
          body: Center(child: Text('Unexpected state')),
        );
      },
    );
  }
}
